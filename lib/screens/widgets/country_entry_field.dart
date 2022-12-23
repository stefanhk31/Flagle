import 'package:flagle/data/models/country.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryEntryField extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _autocompleteKey = GlobalKey();

  CountryEntryField({
    Key? key,
  }) : super(key: key);

  void clear() {
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: RawAutocomplete<Country>(
              key: _autocompleteKey,
              focusNode: _focusNode,
              textEditingController: _textEditingController,
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                );
              },
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
              optionsViewBuilder: (context,
                  AutocompleteOnSelected<Country> onSelected,
                  Iterable<Country> options) {
                return Material(
                  elevation: 4.0,
                  child: ListView(
                    children: options
                        .map((Country option) => GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(option.name),
                              ),
                            ))
                        .toList(),
                  ),
                );
              },
              onSelected: (country) {
                context.read<QuizBloc>().add(CountryEntered(country: country));
              }),
        ),
      ),
    );
  }
}
