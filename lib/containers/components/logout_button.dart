import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/presentation/components/logout_button_ui.dart';
import 'package:pmsb4/routes.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';
class _ViewModel {
  final Function logout;

  _ViewModel({this.logout});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(logout: () {
      store.dispatch(UserLogout());
      Keys.navKey.currentState.pushNamed(Routes.home);
    });
  }
}
class LogoutButton extends StatelessWidget {
  LogoutButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel _viewModel) {
        return LogoutButtonUI(
          logout: _viewModel.logout,
        );
      },
    );
  }
}


