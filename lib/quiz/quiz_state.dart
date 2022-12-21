part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final List<Country> countriesEntered;
  final int maxAttempts;
  final Country? country;
  const QuizState({
    required this.countriesEntered,
    required this.maxAttempts,
    this.country,
  });

  factory QuizState.initial() {
    return QuizState(
      countriesEntered: const [],
      maxAttempts: Constants.maxAttempts,
    );
  }

  @override
  List<Object?> get props => [countriesEntered, maxAttempts, country];

  @override
  bool get stringify => true;

  QuizState copyWith({
    List<Country>? countriesEntered,
    int? maxAttempts,
    Country? country,
  }) {
    return QuizState(
      countriesEntered: countriesEntered ?? this.countriesEntered,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      country: country ?? this.country,
    );
  }
}

class QuizWon extends QuizState {
  const QuizWon({
    required List<Country> countriesEntered,
    required int maxAttempts,
    required Country country,
  }) : super(
          countriesEntered: countriesEntered,
          maxAttempts: maxAttempts,
          country: country,
        );
}

class QuizLost extends QuizState {
  const QuizLost({
    required List<Country> countriesEntered,
    required int maxAttempts,
    required Country country,
  }) : super(
          countriesEntered: countriesEntered,
          maxAttempts: maxAttempts,
          country: country,
        );
}

class QuizError extends QuizState {
  final String errorMessage;

  const QuizError({
    required this.errorMessage,
    required List<Country> countriesEntered,
    required int maxAttempts,
  }) : super(
          countriesEntered: countriesEntered,
          maxAttempts: maxAttempts,
        );
}
