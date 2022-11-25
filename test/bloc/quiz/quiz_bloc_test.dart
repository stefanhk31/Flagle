import 'package:bloc_test/bloc_test.dart';
import 'package:flagle/constants/constants.dart';
import 'package:flagle/countries/countries_bloc.dart';
import 'package:flagle/quiz/quiz_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/test_utilities.dart';

class MockCountriesBloc extends MockBloc<CountriesEvent, CountriesState>
    implements CountriesBloc {}

void main() {
  late CountriesBloc countriesBloc;

  group('Quiz Bloc', () {
    setUp(() {
      countriesBloc = MockCountriesBloc();
    });

    test('initial state is Quiz State', () {
      expect(QuizBloc(countriesBloc).state, equals(QuizState.initial()));
    });


    //TODO: make this into a regular test so we can check that the country is not null without caring about its specific value
    blocTest<QuizBloc, QuizState>(
      'emits updated quiz state when quiz is started',
      build: () => QuizBloc(countriesBloc),
      seed: () => QuizState.initial(),
      act: (bloc) {
        when(() => countriesBloc.state).thenAnswer(
          (_) => CountriesState(countries: TestUtilities.countries),
        );
        bloc.add(QuizStarted());
      },
      expect: () => [
        QuizState(
          attempts: 0,
          maxAttempts: Constants.maxAttempts,
          country: ,
        )
      ],
    );
  });
}
