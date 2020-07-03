import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/logged_action.dart';
import 'package:pmsb4/presentations/logged/login_page2_ds.dart';
import 'package:pmsb4/presentations/logged/login_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/types_states.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final Function(String) sendPasswordResetEmail;
  final Function(String, String) loginEmailPassword;
  final Function loginGoogle;
  final LoggedAuthenticationStatus authenticationStatus;
  _ViewModel({
    this.loginEmailPassword,
    this.loginGoogle,
    this.authenticationStatus,
    this.sendPasswordResetEmail,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      loginEmailPassword: (String email, String password) {
        store.dispatch(
            LoginEmailPasswordLoggedAction(email: email, password: password));
      },
      loginGoogle: () {
        store.dispatch(LoginGoogleLoggedAction());
      },
      authenticationStatus: store.state.loggedState.authenticationStatusLogged,
      sendPasswordResetEmail: (String email) {
        store.dispatch(SendPasswordResetEmailLoggedAction(email: email));
      },
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
        return LoginPage2DS(
          loginEmailPassword: viewModel.loginEmailPassword,
          loginGoogle: viewModel.loginGoogle,
          authenticationStatus: viewModel.authenticationStatus,
          sendPasswordResetEmail: viewModel.sendPasswordResetEmail,
        );
      },
    );
  }
}
