import 'package:flagle/data/models/country.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_utilities.dart';

void main() {
  group('Quiz State', () {
    late List<Country> testCountries;

    setUp(() {
      testCountries = TestUtilities.generateTestCountries(1);
    });

    test('supports value equality', () {});

    group('copyWith', () {
      test('updates country', () {
        final instanceA = QuizState.initial();
        final instanceB = instanceA.copyWith(country: testCountries[0]);
        expect(instanceB.country, equals(testCountries[0]));
      });

      test('updates countries entered', () {
        final instanceA = QuizState.initial();
        final instanceB =
            instanceA.copyWith(countriesEntered: [testCountries[0]]);
        expect(instanceB.countriesEntered, equals([testCountries[0]]));
      });
    });
  });
}
