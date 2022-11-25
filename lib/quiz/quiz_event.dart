// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quiz_bloc.dart';

abstract class QuizEvent {}

class QuizStarted extends QuizEvent {}

class CountryEntered extends QuizEvent {
  final Country country;
  CountryEntered({
    required this.country,
  });
}

class QuizCompleted extends QuizEvent {
  final bool success;
  QuizCompleted({
    required this.success,
  });
}
