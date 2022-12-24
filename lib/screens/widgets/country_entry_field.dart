import 'package:flagle/data/models/country.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    return _CountryAutocomplete(
        autocompleteKey: _autocompleteKey,
        focusNode: _focusNode,
        textEditingController: _textEditingController);
  }
}

class _CountryAutocomplete extends StatelessWidget {
  const _CountryAutocomplete({
    Key? key,
    required GlobalKey<State<StatefulWidget>> autocompleteKey,
    required FocusNode focusNode,
    required TextEditingController textEditingController,
  })  : _autocompleteKey = autocompleteKey,
        _focusNode = focusNode,
        _textEditingController = textEditingController,
        super(key: key);

  final GlobalKey<State<StatefulWidget>> _autocompleteKey;
  final FocusNode _focusNode;
  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<Country>(
        key: _autocompleteKey,
        focusNode: _focusNode,
        textEditingController: _textEditingController,
        fieldViewBuilder: _fieldViewBuilder,
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
        optionsViewBuilder: _optionsViewBuilder,
        onSelected: (country) {
          context.read<QuizBloc>().add(CountryEntered(country: country));
        });
  }

  Widget _optionsViewBuilder(context,
      AutocompleteOnSelected<Country> onSelected, Iterable<Country> options) {
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 150.0),
        child: Material(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: ((context, index) {
                final Country option = options.elementAt(index);
                return InkWell(
                  onTap: () {
                    onSelected(option);
                  },
                  child: _autocompleteOptionBuilder(index, option),
                );
              })),
        ),
      ),
    );
  }

  Builder _autocompleteOptionBuilder(int index, Country option) {
    return Builder(builder: (context) {
      final bool highlight = AutocompleteHighlightedOption.of(context) == index;
      if (highlight) {
        SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
          Scrollable.ensureVisible(context, alignment: 0.5);
        });
      }
      return Container(
        color: highlight ? Theme.of(context).focusColor : null,
        padding: const EdgeInsets.all(16.0),
        child: Text(option.name),
      );
    });
  }

  Widget _fieldViewBuilder(
      context, textEditingController, focusNode, onFieldSubmitted) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }
}
