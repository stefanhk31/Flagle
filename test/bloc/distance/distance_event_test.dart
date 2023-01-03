import 'dart:js_util';

import 'package:flagle/data/models/distance.dart';
import 'package:flagle/distance/distance_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Distance Event', () {
    test('Unit Changed supports value equality', () {
      const instanceA = UnitChanged(unit: Unit.km);
      const instanceB = UnitChanged(unit: Unit.km);
      expect(instanceA, equals(instanceB));
    });
  });
}
