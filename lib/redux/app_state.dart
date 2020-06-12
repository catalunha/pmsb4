import 'package:meta/meta.dart';
import 'package:pmsb4/actions/counter_action.dart';
import 'package:pmsb4/states/counter_state.dart';

@immutable
class AppState {
  final CounterState counterState;

  AppState({
    this.counterState,
  });
  factory AppState.initial() {
    return AppState(
      counterState: CounterState.initial(),
    );
  }

  AppState copyWith({
    CounterState counterState,
  }) {
    return AppState(counterState: counterState ?? this.counterState);
  }

  @override
  int get hashCode => counterState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          counterState == other.counterState;
  @override
  String toString() {
    return 'AppState{counterState:$counterState}';
  }
}
