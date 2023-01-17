import 'package:flagle/data/distance_repository.dart';
import 'package:flagle/distance/distance_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flagle/data/models/country.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              _distanceFromAnswer(context, countries[index]),
              _quizIcon(index),
            ],
          );
        },
        separatorBuilder: ((context, index) => const Divider()),
        itemCount: countries.length);
  }

  Text _distanceFromAnswer(BuildContext context, Country enteredCountry) {
    if (country == null) {
      throw Exception('No answer country');
    }

    final unit = context.read<DistanceBloc>().state.unit;

    final distance = context
        .read<DistanceRepository>()
        .getDistance(enteredCountry, country!, unit);

    return Text(
        '${distance.distance.ceil()} ${distance.unit.name} from correct answer');
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
