import 'package:pmsb4/states/counter_state.dart';

int factorial(int n) {
  if (n <= 1) {
    return 1;
  }
  return n * factorial(n - 1);
}

int factorialCounterSelector(CounterState state) => factorial(state.counter);
