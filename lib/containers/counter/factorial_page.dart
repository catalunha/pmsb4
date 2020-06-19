import 'package:pmsb4/selectors/selector.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final int factorial;

  _ViewModel({this.factorial});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        factorial: factorialCounterSelector(store.state.counterState));
  }
}

