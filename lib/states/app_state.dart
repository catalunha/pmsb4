import 'package:meta/meta.dart';
import 'package:pmsb4/states/collection_state.dart';
import 'package:pmsb4/states/counter_state.dart';
import 'package:pmsb4/states/kanban_board_state.dart';
import 'package:pmsb4/states/kanban_card_state.dart';
import 'package:pmsb4/states/user_state.dart';
import 'package:pmsb4/states/users_state.dart';

@immutable
class AppState {
  final CounterState counterState;
  final UserState userState;
  final CollectionState collectionState;
  final KanbanBoardState kanbanBoardState;
  final KanbanCardState kanbanCardState;
  final UsersState usersState;
  AppState(
      {this.counterState,
      this.userState,
      this.collectionState,
      this.kanbanBoardState,
      this.kanbanCardState,
      this.usersState});
  factory AppState.initial() {
    return AppState(
      counterState: CounterState.initial(),
      userState: UserState.initial(),
      collectionState: CollectionState.initial(),
      kanbanBoardState: KanbanBoardState.initial(),
      kanbanCardState: KanbanCardState.initial(),
      usersState: UsersState.initial(),
    );
  }

  AppState copyWith({
    CounterState counterState,
    UserState userState,
    CollectionState collectionState,
    KanbanBoardState kanbanBoardState,
    KanbanCardState kanbanCardState,
    UsersState usersState,
  }) {
    return AppState(
      counterState: counterState ?? this.counterState,
      userState: userState ?? this.userState,
      collectionState: collectionState ?? this.collectionState,
      kanbanBoardState: kanbanBoardState ?? this.kanbanBoardState,
      kanbanCardState: kanbanCardState ?? this.kanbanCardState,
      usersState: usersState ?? this.usersState,
    );
  }

  @override
  int get hashCode =>
      counterState.hashCode ^
      userState.hashCode ^
      collectionState.hashCode ^
      kanbanBoardState.hashCode ^
      kanbanCardState.hashCode ^
      usersState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          counterState == other.counterState &&
          userState == other.userState &&
          collectionState == other.collectionState &&
          kanbanBoardState == other.kanbanBoardState &&
          kanbanCardState == other.kanbanCardState &&
          usersState == other.usersState;
  @override
  String toString() {
    return 'AppState{counterState:$counterState, userState: $userState, collectionState:$collectionState,kanbanBoardState:$kanbanBoardState}';
  }
}
