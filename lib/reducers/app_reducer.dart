import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/actions/logged_action.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/reducers/kanban_board_reducer.dart';
import 'package:pmsb4/reducers/kanban_card_reducer.dart';
import 'package:pmsb4/reducers/logged_reducer.dart';
import 'package:pmsb4/reducers/user_reducer.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, LoggedAction>(_loggedAction),
  TypedReducer<AppState, KanbanBoardAction>(_kanbanBoardAction),
  TypedReducer<AppState, KanbanCardAction>(_kanbanCardAction),
  TypedReducer<AppState, UserAction>(_userAction),
]);

AppState _loggedAction(AppState state, LoggedAction action) {
  print('_userAction...');
  return state.copyWith(loggedState: loggedReducer(state.loggedState, action));
}

AppState _kanbanBoardAction(AppState state, KanbanBoardAction action) {
  print('_kanbanBoardAction...');
  return state.copyWith(
      kanbanBoardState: kanbanBoardReducer(state.kanbanBoardState, action));
}

AppState _kanbanCardAction(AppState state, KanbanCardAction action) {
  print('_kanbanCardAction...');
  return state.copyWith(
      kanbanCardState: kanbanCardReducer(state.kanbanCardState, action));
}

AppState _userAction(AppState state, UserAction action) {
  print('_usersAction...');
  return state.copyWith(usersState: userReducer(state.usersState, action));
}
