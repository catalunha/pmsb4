import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/actions/counter_action.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/reducers/collection_reducer.dart';
import 'package:pmsb4/reducers/counter_reducer.dart';
import 'package:pmsb4/reducers/kanban_board_reducer.dart';
import 'package:pmsb4/reducers/user_reducer.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, CounterAction>(_counterAction),
  TypedReducer<AppState, UserAction>(_userAction),
  TypedReducer<AppState, CollectionAction>(_collectionAction),
  TypedReducer<AppState, KanbanBoardAction>(_kanbanBoardAction),
]);

AppState _counterAction(AppState state, CounterAction action) {
  return state.copyWith(
      counterState: counterReducer(state.counterState, action));
}

AppState _userAction(AppState state, UserAction action) {
  return state.copyWith(userState: userReducer(state.userState, action));
}

AppState _collectionAction(AppState state, CollectionAction action) {
  return state.copyWith(
      collectionState: collectionReducer(state.collectionState, action));
}
AppState _kanbanBoardAction(AppState state, KanbanBoardAction action) {
  return state.copyWith(
      kanbanBoardState: kanbanBoardReducer(state.kanbanBoardState, action));
}
