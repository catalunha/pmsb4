import 'package:pmsb4/actions/counter_action.dart';
import 'package:pmsb4/reducers/counter_reducer.dart';
import 'package:pmsb4/redux/app_state.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, CounterAction>(_counterAction),
]);

AppState _counterAction(AppState state, CounterAction action) {
  return state.copyWith(
      counterState: counterReducer(state.counterState, action));
}
