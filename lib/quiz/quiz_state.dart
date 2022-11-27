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

class QuizWon extends QuizState {
  const QuizWon({
    required int attempts,
    required int maxAttempts,
    required Country country,
  }) : super(
          attempts: attempts,
          maxAttempts: maxAttempts,
          country: country,
        );
}

class QuizLost extends QuizState {
  const QuizLost({
    required int attempts,
    required int maxAttempts,
    required Country country,
  }) : super(
          attempts: attempts,
          maxAttempts: maxAttempts,
          country: country,
        );
}

class QuizError extends QuizState {
  final String errorMessage;

  const QuizError({
    required this.errorMessage,
    required int attempts,
    required int maxAttempts,
  }) : super(
          attempts: attempts,
          maxAttempts: maxAttempts,
        );
}
