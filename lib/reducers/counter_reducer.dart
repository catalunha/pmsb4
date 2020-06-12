import 'package:pmsb4/actions/counter_action.dart';
import 'package:pmsb4/states/counter_state.dart';
import 'package:redux/redux.dart';

final counterReducer = combineReducers<CounterState>([
  TypedReducer<CounterState, IncrementCounterAction>(_incrementCounterAction),
]);

CounterState _incrementCounterAction(
    CounterState state, IncrementCounterAction action) {
  int counter = state.counter;
  counter = counter + 1;
  return state.copyWith(
    counter: counter,
  );
}
