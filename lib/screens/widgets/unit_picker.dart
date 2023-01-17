import 'package:flagle/data/models/distance.dart';
import 'package:flagle/distance/distance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnitPicker extends StatelessWidget {
  const UnitPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Unit unitValue = context.read<DistanceBloc>().state.unit;

    return BlocListener<DistanceBloc, DistanceState>(
      listener: (context, state) {
        unitValue = context.read<DistanceBloc>().state.unit;
      },
      child: DropdownButton<Unit>(
        value: unitValue,
        items: _unitOptions(),
        onChanged: (Unit? value) {
          if (value != null) {
            context.read<DistanceBloc>().add(UnitChanged(unit: value));
          }
        },
      ),
    );
  }

  List<DropdownMenuItem<Unit>> _unitOptions() {
    List<DropdownMenuItem<Unit>> units = [];

    for (var unit in Unit.values) {
      units.add(DropdownMenuItem(value: unit, child: Text(unit.toString())));
    }

    return units;
  }
}
