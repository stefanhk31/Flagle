// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flagle/data/models/country.dart';

class CountriesEntered extends StatelessWidget {
  final List<Country> countries;
  final Country? country;

  const CountriesEntered({
    Key? key,
    required this.countries,
    this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                countries[index].name,
              ),
              _quizIcon(index),
            ],
          );
        },
        separatorBuilder: ((context, index) => const Divider()),
        itemCount: countries.length);
  }

  Icon _quizIcon(int index) {
    return countries[index].name == country!.name
        ? const Icon(
            Icons.check,
            color: Colors.green,
          )
        : const Icon(
            Icons.close,
            color: Colors.red,
          );
  }
}
