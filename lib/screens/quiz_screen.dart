import 'package:flagle/constants/constants.dart';
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
          if (state.countries.isEmpty) {
            context.read<CountriesBloc>().add(CountriesLoadStarted());
          }
          if (state is CountriesErrorState) {
            return const Center(
              child: Text('Oops! Something went wrong.'),
            );
          } else if (state.countries.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return BlocConsumer<QuizBloc, QuizState>(
              listener: (context, state) {
                void restart() => context.read<QuizBloc>().add(QuizStarted());
                if (state is QuizWon) {
                  showEndOfGameDialog('You Won!', restart, context);
                } else if (state is QuizLost) {
                  showEndOfGameDialog('You Lost. :(', restart, context);
                }
              },
              builder: ((context, state) {
                if (state.country != null) {
                  var attemptsRemaining =
                      context.read<QuizBloc>().state.maxAttempts -
                          context.read<QuizBloc>().state.attempts;
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Flagle'),
                    ),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$attemptsRemaining out of ${Constants.maxAttempts} attempts left.',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                        Expanded(
                            child: getFlagWidget(context
                                .read<QuizBloc>()
                                .state
                                .country!
                                .flagSrc)),
                        Expanded(
                          child: Center(
                            child: Autocomplete<Country>(
                              displayStringForOption: (country) => country.name,
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                List<Country> matches = [];
                                if (textEditingValue.text.length > 2) {
                                  matches = context
                                      .read<QuizBloc>()
                                      .countriesBloc
                                      .state
                                      .countries
                                      .where(
                                        (Country c) =>
                                            c.name.toLowerCase().contains(
                                                  textEditingValue.text
                                                      .toLowerCase(),
                                                ),
                                      )
                                      .toList();
                                }

                                return matches;
                              },
                              onSelected: (country) {
                                context
                                    .read<QuizBloc>()
                                    .add(CountryEntered(country: country));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  context.read<QuizBloc>().add(QuizStarted());
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            );
          }
        },
      ),
    );
  }

  void showEndOfGameDialog(
      String title, Function restart, BuildContext context) {
    var countryName = context.read<QuizBloc>().state.country!.name;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text('This is the flag of $countryName.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Play Again!');
                    restart();
                  },
                  child: const Text('Play Again!'),
                ),
              ],
            ));
  }

  Widget getFlagWidget(String imgSrc) {
    if (imgSrc.endsWith('png')) {
      return Image.network(imgSrc);
    }
    return SvgPicture.network(imgSrc);
  }
}
