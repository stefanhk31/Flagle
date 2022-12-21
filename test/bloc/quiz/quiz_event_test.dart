import 'package:flagle/data/models/country.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_utilities.dart';

void main() {
  group('Quiz Event', () {
    late List<Country> testCountries;

    setUp(() {
      testCountries = TestUtilities.generateTestCountries(1);
    });

    test('Quiz Started supports value equality', () {
      final instanceA = QuizStarted();
      final instanceB = QuizStarted();
      expect(instanceA, equals(instanceB));
    });

    test('Country Entered supports value equality', () {
      final country = testCountries[0];
      final instanceA = CountryEntered(country: country);
      final instanceB = CountryEntered(country: country);
      expect(instanceA, equals(instanceB));
    });
  });
}
