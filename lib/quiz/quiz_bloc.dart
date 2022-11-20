import 'package:equatable/equatable.dart';
import 'package:flagle/data/models/country.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizState.initial()) {
    on<QuizEvent>((event, emit) {
      if (event is CountryEntered) {
        _handleCountryEntered(event, emit);
      }
      if (event is QuizCompleted) {
        _handleQuizCompleted(event, emit);
      }
    });
  }

  void _handleCountryEntered(CountryEntered event, Emitter<QuizState> emit) {}

  void _handleQuizCompleted(QuizCompleted event, Emitter<QuizState> emit) {}
}
