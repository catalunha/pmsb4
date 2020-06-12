import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/presentation/user/auth_button_ui.dart';
import 'package:pmsb4/redux/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final String buttonText;
  final Function onPressedCallBack;

  _ViewModel({this.buttonText, this.onPressedCallBack});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        buttonText: store.state.userState.firebaseUser == null
            ? 'Log in with Google'
            : 'Log Out',
        onPressedCallBack: () {
          print('store.state.userState.firebaseUser');
          print(store.state.userState.firebaseUser);
          if (store.state.userState.firebaseUser == null) {
            store.dispatch(UserLogin());
          } else {
            store.dispatch(UserLogout());
          }
        });
  }
}

class AuthButton extends StatelessWidget {
  AuthButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel _viewModel) {
        return AuthButtonUI(
          buttonText: _viewModel.buttonText,
          onPressedCallBack: _viewModel.onPressedCallBack,
        );
      },
    );
  }
}
