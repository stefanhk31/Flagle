import 'package:flagle/countries/countries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Countries State', () {
    test('supports value equality', () {
      final instanceA = CountriesState.initial();
      final instanceB = CountriesState.initial();
      expect(instanceA, equals(instanceB));
    });
  });
}
