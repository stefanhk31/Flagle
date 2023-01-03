import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flagle/data/models/distance.dart';

part 'distance_event.dart';
part 'distance_state.dart';

class DistanceBloc extends Bloc<DistanceEvent, DistanceState> {
  DistanceBloc() : super(DistanceState.initial()) {
    on<DistanceEvent>((event, emit) {
      try {
        if (event is UnitChanged) {
          _handleUnitChanged(event, emit);
        }
      } on Exception catch (e) {
        emit(
          DistanceError(
            errorMessage: e.toString(),
            unit: state.unit,
          ),
        );
      }
    });
  }

  void _handleUnitChanged(UnitChanged event, Emitter<DistanceState> emit) {
    emit(state.copyWith(unit: event.unit));
  }
}
