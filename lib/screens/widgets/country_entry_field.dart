import 'package:flagle/data/models/country.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryEntryField extends StatelessWidget {
  const CountryEntryField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Autocomplete<Country>(
              displayStringForOption: (country) => country.name,
              optionsBuilder: (TextEditingValue textEditingValue) {
                List<Country> matches = [];
                if (textEditingValue.text.length > 2) {
                  matches = context
                      .read<QuizBloc>()
                      .countriesBloc
                      .state
                      .countries
                      .where(
                        (Country c) => c.name.toLowerCase().contains(
                              textEditingValue.text.toLowerCase(),
                            ),
                      )
                      .toList();
                }

                return matches;
              },
              onSelected: (country) {
                context.read<QuizBloc>().add(CountryEntered(country: country));
              }),
        ),
      ),
    );
  }
}
