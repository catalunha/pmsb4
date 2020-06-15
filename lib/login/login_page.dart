import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/presentation/login/login_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final Function(String, String) loginEmailPassword;
  final Function loginGoogle;
  final AuthenticationStatus authenticationStatus;
  _ViewModel({
    this.loginEmailPassword,
    this.loginGoogle,
    this.authenticationStatus,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      loginEmailPassword: (String email, String password) {
        store
            .dispatch(UserLoginEmailPassword(email: email, password: password));
      },
      loginGoogle: () {
        store.dispatch(UserLoginGoogle());
      },
      authenticationStatus: store.state.userState.authenticationStatus,
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel viewModel) {
        return LoginPageDS(
          loginEmailPassword: viewModel.loginEmailPassword,
          loginGoogle: viewModel.loginGoogle,
          authenticationStatus: viewModel.authenticationStatus,
        );
      },
    );
  }
}
