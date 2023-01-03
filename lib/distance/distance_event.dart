part of 'distance_bloc.dart';

abstract class DistanceEvent extends Equatable {
  const DistanceEvent();

  @override
  List<Object> get props => [];
}

class UnitChanged extends DistanceEvent {
  final Unit unit;

  const UnitChanged({required this.unit});
}
