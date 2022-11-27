import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_utilities.dart';

void main() {
  group('Quiz State', () {
    test('supports value equality', () {});

    group('copyWith', () {
      test('updates country', () {
        final instanceA = QuizState.initial();
        final instanceB =
            instanceA.copyWith(country: TestUtilities.countries[0]);
        expect(instanceB.country, equals(TestUtilities.countries[0]));
      });

      test('updates attempts', () {
        final instanceA = QuizState.initial();
        final instanceB = instanceA.copyWith(attempts: 1);
        expect(instanceB.attempts, equals(1));
      });
    });
  });
}
