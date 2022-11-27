import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_utilities.dart';

void main() {
  group('Quiz Event', () {
    test('Quiz Started supports value equality', () {
      final instanceA = QuizStarted();
      final instanceB = QuizStarted();
      expect(instanceA, equals(instanceB));
    });

    test('Country Entered supports value equality', () {
      final country = TestUtilities.countries[0];
      final instanceA = CountryEntered(country: country);
      final instanceB = CountryEntered(country: country);
      expect(instanceA, equals(instanceB));
    });
  });
}
