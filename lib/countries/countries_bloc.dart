import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flagle/data/country_repository.dart';
import 'package:flagle/data/models/country.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesBloc(CountryRepository countryRepository)
      : super(CountriesState.initial()) {
    on<CountriesEvent>((event, emit) async {
      if (event is CountriesLoadStarted) {
        await _handleCountriesLoadStarted(event, emit, countryRepository);
      }
    });
  }

  Future<void> _handleCountriesLoadStarted(CountriesLoadStarted event,
      Emitter<CountriesState> emit, CountryRepository countryRepository) async {
    List<Country> countries = [];
    try {
      countries = await countryRepository.getCountries();
      emit(CountriesState(countries: countries));
    } on Error {
      emit(
        CountriesErrorState(
            countries: countries, errorMessage: 'Could not load countries.'),
      );
    }
  }
}
