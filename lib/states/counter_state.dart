import 'package:meta/meta.dart';

@immutable
class CounterState {
  final int counter;

  CounterState({
    this.counter,
  });
  factory CounterState.initial() {
    return CounterState(
      counter: 0,
    );
  }
  CounterState copyWith({int counter}) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }

  @override
  int get hashCode => counter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterState &&
          runtimeType == other.runtimeType &&
          counter == other.counter;
  @override
  String toString() {
    return 'CounterState{counter:$counter}';
  }
}
