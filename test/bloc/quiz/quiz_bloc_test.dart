import 'package:bloc_test/bloc_test.dart';
import 'package:flagle/constants/constants.dart';
import 'package:flagle/countries/countries_bloc.dart';
import 'package:flagle/data/models/country.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/test_utilities.dart';

class MockCountriesBloc extends MockBloc<CountriesEvent, CountriesState>
    implements CountriesBloc {}

void main() {
  late CountriesBloc countriesBloc;
  Country? result;

  group('Quiz Bloc', () {
    setUp(() {
      countriesBloc = MockCountriesBloc();
      when(() => countriesBloc.state).thenAnswer(
        (_) => CountriesState(countries: TestUtilities.countries),
      );
    });

    test('initial state is Quiz State', () {
      expect(QuizBloc(countriesBloc).state, equals(QuizState.initial()));
    });

    blocTest<QuizBloc, QuizState>(
      'country is not null when quiz is started',
      build: () => QuizBloc(countriesBloc),
      seed: () => QuizState.initial(),
      act: (bloc) async {
        bloc.add(QuizStarted());
        await Future.delayed(const Duration(milliseconds: 500), () {
          result = bloc.state.country!;
        });
      },
      expect: () => [
        QuizState(
          attempts: 0,
          maxAttempts: Constants.maxAttempts,
          country: result!,
        )
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'emits quiz completed',
      build: () => QuizBloc(countriesBloc),
      seed: () => QuizState.initial(),
      act: (bloc) async {
        bloc.add(QuizStarted());
        await Future.delayed(const Duration(milliseconds: 500), () {
          result = bloc.state.country!;
        });
      },
      expect: () => [
        QuizState(
          attempts: 0,
          maxAttempts: Constants.maxAttempts,
          country: result!,
        )
      ],
    );
  });
}
