import 'package:bloc_test/bloc_test.dart';
import 'package:flagle/data/models/distance.dart';
import 'package:flagle/distance/distance_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Distance Bloc', () {
    test('initial state is Distance State', () {
      expect(DistanceBloc().state, equals(DistanceState.initial()));
    });

    blocTest<DistanceBloc, DistanceState>(
      'changing unit updates state',
      build: () => DistanceBloc(),
      seed: () => DistanceState.initial(),
      act: (bloc) async {
        bloc.add(const UnitChanged(unit: Unit.km));
      },
      expect: () => [
        const DistanceState(
          unit: Unit.km,
        )
      ],
    );
  });
}
