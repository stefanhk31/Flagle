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
      try {
        if (event is QuizStarted) {
          _handleQuizStarted(event, emit);
        }
        if (event is CountryEntered) {
          _handleCountryEntered(event, emit);
        }
      } on Exception catch (e) {
        emit(
          QuizError(
              errorMessage: e.toString(),
              attempts: state.attempts,
              maxAttempts: state.maxAttempts),
        );
      }
    });
  }

  void _handleQuizStarted(QuizStarted event, Emitter<QuizState> emit) {
    var countries = countriesBloc.state.countries;
    var index = Random().nextInt(countries.length);
    emit(state.copyWith(attempts: 0, country: countries[index]));
  }

  void _handleCountryEntered(CountryEntered event, Emitter<QuizState> emit) {
    if (state.country == null) {
      throw Exception(Constants.countryNullError);
    }

    var updatedAttempts = state.attempts + 1;

    if (event.country.name == state.country!.name) {
      emit(QuizWon(
        attempts: updatedAttempts,
        maxAttempts: Constants.maxAttempts,
        country: state.country!,
      ));
    } else if (updatedAttempts >= Constants.maxAttempts) {
      emit(QuizLost(
        attempts: updatedAttempts,
        maxAttempts: Constants.maxAttempts,
        country: state.country!,
      ));
    } else {
      emit(state.copyWith(
        attempts: updatedAttempts,
      ));
    }
  }
}
