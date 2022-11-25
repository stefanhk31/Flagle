import 'package:flagle/countries/countries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_utilities.dart';

void main() {
  group('Countries State', () {
    test('initial Countries State supports value equality', () {
      final instanceA = CountriesState.initial();
      final instanceB = CountriesState.initial();
      expect(instanceA, equals(instanceB));
    });

    test('Populated Countries State supports value equality', () {
      final countries = TestUtilities.countries;
      final instanceA = CountriesState(countries: countries);
      final instanceB = CountriesState(countries: countries);
      expect(instanceA, equals(instanceB));
    });

    test('Countries Error State supports value equality', () {
      const errorMessage = 'error';
      const instanceA =
          CountriesErrorState(countries: [], errorMessage: errorMessage);
      const instanceB =
          CountriesErrorState(countries: [], errorMessage: errorMessage);
      expect(instanceA, equals(instanceB));
    });
  });
}
