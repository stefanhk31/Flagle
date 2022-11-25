import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flagle/constants/constants.dart';
import 'package:flagle/countries/countries_bloc.dart';
import 'package:flagle/data/models/country.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final CountriesBloc countriesBloc;

  QuizBloc(this.countriesBloc) : super(QuizState.initial()) {
    on<QuizEvent>((event, emit) {
      if (event is QuizStarted) {
        _handleQuizStarted(event, emit);
      }
      if (event is CountryEntered) {
        _handleCountryEntered(event, emit);
      }
      if (event is QuizCompleted) {
        _handleQuizCompleted(event, emit);
      }
    });
  }

  void _handleQuizStarted(QuizStarted event, Emitter<QuizState> emit) {
    var countries = countriesBloc.state.countries;
    var index = Random().nextInt(countries.length);
    emit(state.copyWith(country: countries[index]));
  }

  void _handleCountryEntered(CountryEntered event, Emitter<QuizState> emit) {}

  void _handleQuizCompleted(QuizCompleted event, Emitter<QuizState> emit) {}
}
