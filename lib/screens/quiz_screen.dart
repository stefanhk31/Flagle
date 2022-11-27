import 'package:flagle/countries/countries_bloc.dart';
import 'package:flagle/data/country_repository.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          } else {}
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
