import 'package:meta/meta.dart';
import 'package:pmsb4/states/counter_state.dart';
import 'package:pmsb4/states/kanban_board_state.dart';
import 'package:pmsb4/states/kanban_card_state.dart';
import 'package:pmsb4/states/logged_state.dart';
import 'package:pmsb4/states/user_state.dart';

@immutable
class AppState {
  final CounterState counterState;
  final LoggedState loggedState;
  final KanbanBoardState kanbanBoardState;
  final KanbanCardState kanbanCardState;
  final UserState usersState;
  AppState(
      {this.counterState,
      this.loggedState,
      this.kanbanBoardState,
      this.kanbanCardState,
      this.usersState});
  factory AppState.initial() {
    return AppState(
      counterState: CounterState.initial(),
      loggedState: LoggedState.initial(),
      kanbanBoardState: KanbanBoardState.initial(),
      kanbanCardState: KanbanCardState.initial(),
      usersState: UserState.initial(),
    );
  }

  AppState copyWith({
    CounterState counterState,
    LoggedState loggedState,
    KanbanBoardState kanbanBoardState,
    KanbanCardState kanbanCardState,
    UserState usersState,
  }) {
    return AppState(
      counterState: counterState ?? this.counterState,
      loggedState: loggedState ?? this.loggedState,
      kanbanBoardState: kanbanBoardState ?? this.kanbanBoardState,
      kanbanCardState: kanbanCardState ?? this.kanbanCardState,
      usersState: usersState ?? this.usersState,
    );
  }

  @override
  int get hashCode =>
      counterState.hashCode ^
      loggedState.hashCode ^
      kanbanBoardState.hashCode ^
      kanbanCardState.hashCode ^
      usersState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          counterState == other.counterState &&
          loggedState == other.loggedState &&
          kanbanBoardState == other.kanbanBoardState &&
          kanbanCardState == other.kanbanCardState &&
          usersState == other.usersState;
  @override
  String toString() {
    return 'AppState{counterState:$counterState, loggedState: $loggedState,kanbanBoardState:$kanbanBoardState}';
  }
}
