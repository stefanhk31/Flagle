import 'package:flagle/countries/countries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Countries Event', () {
    test('CountriesLoadStarted supports value equality', () {
      final instanceA = CountriesLoadStarted();
      final instanceB = CountriesLoadStarted();
      expect(instanceA, equals(instanceB));
    });
  });
}
