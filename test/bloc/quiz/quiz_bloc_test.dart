import 'package:bloc_test/bloc_test.dart';
import 'package:flagle/constants/constants.dart';
import 'package:flagle/countries/countries_bloc.dart';
import 'package:flagle/data/models/country.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/test_utilities.dart';

class MockCountriesBloc extends MockBloc<CountriesEvent, CountriesState>
    implements CountriesBloc {}

void main() {
  late CountriesBloc countriesBloc;
  late List<Country> testCountries;
  Country? result;

  group('Quiz Bloc', () {
    setUp(() {
      countriesBloc = MockCountriesBloc();
      testCountries = TestUtilities.generateTestCountries(2);
      when(() => countriesBloc.state).thenAnswer(
        (_) => CountriesState(countries: testCountries),
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
          countriesEntered: const [],
          maxAttempts: Constants.maxAttempts,
          country: result!,
        )
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'emits quiz won when correct country is entered',
      build: () => QuizBloc(countriesBloc),
      seed: () => QuizState(
        countriesEntered: const [],
        maxAttempts: Constants.maxAttempts,
        country: testCountries[0],
      ),
      act: (bloc) async {
        bloc.add(CountryEntered(
          country: testCountries[0],
        ));
      },
      expect: () => [
        QuizWon(
          countriesEntered: [testCountries[0]],
          maxAttempts: Constants.maxAttempts,
          country: testCountries[0],
        )
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'emits quiz lost when maxAttempts has been reached',
      build: () => QuizBloc(countriesBloc),
      seed: () => QuizState(
        countriesEntered: const [],
        maxAttempts: 1,
        country: testCountries[0],
      ),
      act: (bloc) async {
        bloc.add(CountryEntered(
          country: testCountries[1],
        ));
      },
      expect: () => [
        QuizLost(
          countriesEntered: [testCountries[1]],
          maxAttempts: 1,
          country: testCountries[0],
        )
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'emits state with updated attempts when an incorrect country is entered and maxAttempts has not been reached',
      build: () => QuizBloc(countriesBloc),
      seed: () => QuizState(
        countriesEntered: const [],
        maxAttempts: Constants.maxAttempts,
        country: testCountries[0],
      ),
      act: (bloc) async {
        bloc.add(CountryEntered(
          country: testCountries[1],
        ));
      },
      expect: () => [
        QuizState(
          countriesEntered: [testCountries[1]],
          maxAttempts: Constants.maxAttempts,
          country: testCountries[0],
        )
      ],
    );

    blocTest<QuizBloc, QuizState>(
      'emits error state when country is selected if there is no correct country',
      build: () => QuizBloc(countriesBloc),
      seed: () => QuizState.initial(),
      act: (bloc) async {
        bloc.add(CountryEntered(
          country: testCountries[0],
        ));
      },
      expect: () => [
        QuizError(
          errorMessage: 'Exception: ${Constants.countryNullError}',
          countriesEntered: const [],
          maxAttempts: Constants.maxAttempts,
        )
      ],
    );
  });
}
