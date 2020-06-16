import 'package:pmsb4/actions/colecao_action.dart';
import 'package:pmsb4/actions/counter_action.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/reducers/colecao_reducer.dart';
import 'package:pmsb4/reducers/counter_reducer.dart';
import 'package:pmsb4/reducers/user_reducer.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, CounterAction>(_counterAction),
  TypedReducer<AppState, UserAction>(_userAction),
  TypedReducer<AppState, ColecaoAction>(_colecaoAction),
]);

AppState _counterAction(AppState state, CounterAction action) {
  return state.copyWith(
      counterState: counterReducer(state.counterState, action));
}

AppState _userAction(AppState state, UserAction action) {
  return state.copyWith(userState: userReducer(state.userState, action));
}

AppState _colecaoAction(AppState state, ColecaoAction action) {
  return state.copyWith(
      colecaoState: colecaoReducer(state.colecaoState, action));
}
