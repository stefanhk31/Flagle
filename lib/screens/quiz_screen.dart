import 'package:flagle/countries/countries_bloc.dart';
import 'package:flagle/data/country_repository.dart';
import 'package:flagle/data/distance_repository.dart';
import 'package:flagle/distance/distance_bloc.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flagle/screens/widgets/unit_picker.dart';
import 'package:flagle/screens/widgets/widgets.dart';

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
        RepositoryProvider(create: (context) => DistanceRepository()),
        RepositoryProvider(create: (context) => CountryRepository()),
        BlocProvider(
          create: (context) =>
              CountriesBloc(RepositoryProvider.of<CountryRepository>(context)),
        ),
        BlocProvider(
          create: (context) =>
              QuizBloc(BlocProvider.of<CountriesBloc>(context)),
        ),
        BlocProvider(
          create: (context) => DistanceBloc(),
        ),
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
                void _restart() => context.read<QuizBloc>().add(QuizStarted());
                if (state is QuizWon) {
                  _showEndOfGameDialog('You Won!', _restart, context);
                } else if (state is QuizLost) {
                  _showEndOfGameDialog('You Lost. :(', _restart, context);
                }
              },
              builder: ((context, state) {
                if (state.country != null) {
                  var attemptsRemaining = context
                          .read<QuizBloc>()
                          .state
                          .maxAttempts -
                      context.read<QuizBloc>().state.countriesEntered.length;
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Flagle'),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          StatusHeader(attemptsRemaining: attemptsRemaining),
                          FlagImage(
                              imgSrc: context
                                  .read<QuizBloc>()
                                  .state
                                  .country!
                                  .flagSrc),
                          CountryEntryField(),
                          const UnitPicker(),
                          Expanded(
                            child: CountriesEntered(
                              countries: context
                                  .read<QuizBloc>()
                                  .state
                                  .countriesEntered,
                              country: context.read<QuizBloc>().state.country,
                            ),
                          ),
                        ],
                      ),
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

  void _showEndOfGameDialog(
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
      ),
    );
  }
}
