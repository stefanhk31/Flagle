import 'package:flagle/countries/countries_bloc.dart';
import 'package:flagle/data/country_repository.dart';
import 'package:flagle/data/models/country.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider(create: (context) => CountryRepository()),
        BlocProvider(
          create: (context) =>
              CountriesBloc(RepositoryProvider.of<CountryRepository>(context)),
        ),
        BlocProvider(
            create: (context) =>
                QuizBloc(BlocProvider.of<CountriesBloc>(context))),
      ],
      child: BlocBuilder<CountriesBloc, CountriesState>(
        builder: (context, state) {
          context.read<CountriesBloc>().add(CountriesLoadStarted());

          if (state is CountriesErrorState) {
            return const Center(
              child: Text('Oops! Something went wrong.'),
            );
          } else if (state.countries.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Flagle'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: getFlagWidget(widget.answer.flagSrc)),
                  Expanded(
                    child: Center(
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          List<Country> matches = [];

                          if (textEditingValue.text.length > 2) {
                            matches = widget.countries
                                .where(
                                  (Country c) => c.name.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase(),
                                      ),
                                )
                                .toList();
                          }

                          List<String> names = [];
                          for (var m in matches) {
                            names.add(m.name);
                          }

                          return names;
                        },
                        onSelected: (name) {
                          debugPrint('You just selected $name');
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget getFlagWidget(String imgSrc) {
    if (imgSrc.endsWith('png')) {
      return Image.network(imgSrc);
    }
    return SvgPicture.network(imgSrc);
  }
}
