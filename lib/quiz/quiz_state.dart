// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final int attempts;
  final int maxAttempts;
  final Country? country;
  const QuizState({
    required this.attempts,
    required this.maxAttempts,
    this.country,
  });

  factory QuizState.initial() {
    return QuizState(
      attempts: 0,
      maxAttempts: Constants.maxAttempts,
    );
  }

  @override
  List<Object?> get props => [attempts, maxAttempts, country];

  @override
  bool get stringify => true;

  QuizState copyWith({
    int? attempts,
    int? maxAttempts,
    Country? country,
  }) {
    return QuizState(
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      country: country ?? this.country,
    );
  }
}
