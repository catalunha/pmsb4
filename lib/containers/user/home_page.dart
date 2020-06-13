import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/containers/counter/counter_page.dart';
import 'package:pmsb4/containers/user/login_page.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        if (_viewModel.logged) {
          return CounterPage(
            title: 'Counter Page',
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}

class _ViewModel {
  final bool logged;

  _ViewModel({
    this.logged,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      logged: store.state.userState.firebaseUser == null ? false : true,
    );
  }
}
