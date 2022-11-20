// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'countries_bloc.dart';

class CountriesState extends Equatable {
  final List<Country> countries;

  const CountriesState({
    required this.countries,
  });

  factory CountriesState.initial() {
    return const CountriesState(countries: []);
  }

  @override
  List<Object> get props => [countries];
}

class CountriesErrorState extends CountriesState {
  final String errorMessage;
  const CountriesErrorState(
      {required List<Country> countries, required this.errorMessage})
      : super(countries: countries);
}
