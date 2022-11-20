import 'package:flagle/data/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GameScreen extends StatefulWidget {
  final List<Country> countries;
  final Country answer;

  const GameScreen({Key? key, required this.countries, required this.answer})
      : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget getFlagWidget(String imgSrc) {
    if (imgSrc.endsWith('png')) {
      return Image.network(imgSrc);
    }
    return SvgPicture.network(imgSrc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flagle'),
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
}
