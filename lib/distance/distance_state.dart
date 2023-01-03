// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'distance_bloc.dart';

class DistanceState extends Equatable {
  final Unit unit;

  const DistanceState({
    required this.unit,
  });

  factory DistanceState.initial() {
    return const DistanceState(unit: Unit.m);
  }

  @override
  List<Object> get props => [unit];

  DistanceState copyWith({
    Unit? unit,
  }) {
    return DistanceState(
      unit: unit ?? this.unit,
    );
  }
}

class DistanceError extends DistanceState {
  final String errorMessage;
  const DistanceError({required this.errorMessage, required Unit unit})
      : super(unit: unit);
}
