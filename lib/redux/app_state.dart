import 'package:meta/meta.dart';
import 'package:pmsb4/states/counter_state.dart';
import 'package:pmsb4/states/user_state.dart';

@immutable
class AppState {
  final CounterState counterState;
  final UserState userState;
  AppState({
    this.counterState,
    this.userState,
  });
  factory AppState.initial() {
    return AppState(
      counterState: CounterState.initial(),
      userState: UserState.initial(),
    );
  }

  AppState copyWith({
    CounterState counterState,
    UserState userState,
  }) {
    return AppState(
      counterState: counterState ?? this.counterState,
      userState: userState ?? this.userState,
    );
  }

  @override
  int get hashCode => counterState.hashCode ^ userState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          counterState == other.counterState &&
          userState == other.userState;
  @override
  String toString() {
    return 'AppState{counterState:$counterState, userState: $userState}';
  }
}
