// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'countries_bloc.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object> get props => [];
}

class CountriesLoadStarted extends CountriesEvent {}
