// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {}

class QuizStarted extends QuizEvent {
  @override
  List<Object?> get props => [];
}

class CountryEntered extends QuizEvent {
  final Country country;
  CountryEntered({
    required this.country,
  });

  @override
  List<Object?> get props => [country];
}
