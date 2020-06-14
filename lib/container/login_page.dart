import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/presentation/login_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final Function login;

  _ViewModel({this.login});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(login: () {
      store.dispatch(UserLogin());
    });
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context,_ViewModel viewModel){
        return LoginPageDS(login:viewModel.login);
      },
    );
  }
}
