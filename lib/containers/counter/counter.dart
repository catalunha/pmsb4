import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/counter_action.dart';
import 'package:pmsb4/presentation/counter/counter_ui.dart';
import 'package:pmsb4/selectors/counter/selector.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, viewModel) {
        return HomePageUI(
          counter: viewModel.counter,
          increment: viewModel.increment,
          factorial: viewModel.factorial,
          title: title,
        );
      },
    );
  }
}

class _ViewModel {
  final int counter;
  final Function increment;
  final int factorial;

  _ViewModel({
    this.increment,
    this.counter,
    this.factorial,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      increment: () => store.dispatch(IncrementCounterAction()),
      counter: store.state.counterState.counter,
      factorial: factorialCounterSelector(store.state.counterState),
    );
  }
}
