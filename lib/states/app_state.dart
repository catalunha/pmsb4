import 'package:meta/meta.dart';
import 'package:pmsb4/states/colecao_state.dart';
import 'package:pmsb4/states/counter_state.dart';
import 'package:pmsb4/states/user_state.dart';

@immutable
class AppState {
  final CounterState counterState;
  final UserState userState;
  final ColecaoState colecaoState;
  AppState({
    this.counterState,
    this.userState,
    this.colecaoState,
  });
  factory AppState.initial() {
    return AppState(
      counterState: CounterState.initial(),
      userState: UserState.initial(),
      colecaoState: ColecaoState.initial(),
    );
  }

  AppState copyWith({
    CounterState counterState,
    UserState userState,
    ColecaoState colecaoState,
  }) {
    return AppState(
      counterState: counterState ?? this.counterState,
      userState: userState ?? this.userState,
      colecaoState: colecaoState ?? this.colecaoState,
    );
  }

  @override
  int get hashCode =>
      counterState.hashCode ^ userState.hashCode ^ colecaoState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          counterState == other.counterState &&
          userState == other.userState &&
          colecaoState == other.colecaoState;
  @override
  String toString() {
    return 'AppState{counterState:$counterState, userState: $userState, colecaoState:$colecaoState}';
  }
}
