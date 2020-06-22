import 'package:meta/meta.dart';
import 'package:pmsb4/states/collection_state.dart';
import 'package:pmsb4/states/counter_state.dart';
import 'package:pmsb4/states/kanban_board_state.dart';
import 'package:pmsb4/states/user_state.dart';

@immutable
class AppState {
  final CounterState counterState;
  final UserState userState;
  final CollectionState collectionState;
  final KanbanBoardState kanbanBoardState;
  AppState({
    this.counterState,
    this.userState,
    this.collectionState,
    this.kanbanBoardState,
  });
  factory AppState.initial() {
    return AppState(
      counterState: CounterState.initial(),
      userState: UserState.initial(),
      collectionState: CollectionState.initial(),
      kanbanBoardState: KanbanBoardState.initial(),
    );
  }

  AppState copyWith({
    CounterState counterState,
    UserState userState,
    CollectionState collectionState,
    KanbanBoardState kanbanBoardState,
  }) {
    return AppState(
      counterState: counterState ?? this.counterState,
      userState: userState ?? this.userState,
      collectionState: collectionState ?? this.collectionState,
      kanbanBoardState: kanbanBoardState ?? this.kanbanBoardState,
    );
  }

  @override
  int get hashCode =>
      counterState.hashCode ^
      userState.hashCode ^
      collectionState.hashCode ^
      kanbanBoardState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          counterState == other.counterState &&
          userState == other.userState &&
          collectionState == other.collectionState &&
          kanbanBoardState == other.kanbanBoardState;
  @override
  String toString() {
    return 'AppState{counterState:$counterState, userState: $userState, collectionState:$collectionState,kanbanBoardState:$kanbanBoardState}';
  }
}
