import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/containers/logged/login_page.dart';
import 'package:pmsb4/presentations/home/home_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final bool logged;

  _ViewModel({
    this.logged,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      logged: store.state.loggedState.firebaseUserLogged == null ? false : true,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        if (_viewModel.logged) {
          return HomePageDS();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
