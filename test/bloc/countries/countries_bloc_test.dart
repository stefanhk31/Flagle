import 'package:bloc_test/bloc_test.dart';
import 'package:flagle/countries/countries_bloc.dart';
import 'package:flagle/data/country_repository.dart';
import 'package:flagle/data/models/country.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/test_utilities.dart';

class MockCountryRepository extends Mock implements CountryRepository {}

void main() {
  late CountryRepository countryRepository;
  late List<Country> countries;
  late String errorMessage;

  group('Countries Bloc', () {
    setUp(() {
      countryRepository = MockCountryRepository();
      countries = TestUtilities.countries;
      errorMessage = 'Could not load countries.';
    });

    test('initial state is Countries State', () {
      expect(CountriesBloc(countryRepository).state,
          equals(CountriesState.initial()));
    });

    group('CountriesLoadStarted', () {
      blocTest<CountriesBloc, CountriesState>(
        'emits updated state when countries are successfully loaded',
        build: () => CountriesBloc(countryRepository),
        seed: () => CountriesState.initial(),
        act: (bloc) {
          when(() => countryRepository.getCountries()).thenAnswer(
            (_) => Future(() => countries),
          );
          bloc.add(CountriesLoadStarted());
        },
        expect: () => [
          CountriesState(countries: countries),
        ],
      );
      blocTest<CountriesBloc, CountriesState>(
        'emits updated error state when countries fail to load',
        build: () => CountriesBloc(countryRepository),
        seed: () => CountriesState.initial(),
        act: (bloc) {
          when(() => countryRepository.getCountries()).thenThrow(
            Error(),
          );
          bloc.add(CountriesLoadStarted());
        },
        expect: () => [
          CountriesErrorState(countries: const [], errorMessage: errorMessage),
        ],
      );
    });
  });
}
