import 'package:flagle/data/models/distance.dart';
import 'package:flagle/distance/distance_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Distance State', () {
    test('supports value equality', () {
      final instanceA = DistanceState.initial();
      final instanceB = DistanceState.initial();
      expect(instanceA, equals(instanceB));
    });

    group('copyWith', () {
      test('updates unit', () {
        final instanceA = DistanceState.initial();
        final instanceB = instanceA.copyWith(unit: Unit.km);
        expect(instanceB.unit, equals(Unit.km));
      });
    });
  });
}
