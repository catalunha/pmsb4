import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/presentations/components/logout_button_ds.dart';
// import 'package:pmsb4/routes.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _WidgetData {
  final Function logout;

  _WidgetData({this.logout});

  static _WidgetData fromStore(Store<AppState> store) {
    return _WidgetData(logout: () {
      store.dispatch(UserLogoutAction());
      // Keys.navKey.currentState.pushNamedAndRemoveUntil(
      //     Routes.home, (Route<dynamic> route) => false);
    });
  }
}

class LogoutButton extends StatelessWidget {
  LogoutButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _WidgetData>(
      converter: _WidgetData.fromStore,
      builder: (BuildContext context, _WidgetData _viewModel) {
        return LogoutButtonDS(
          logout: _viewModel.logout,
        );
      },
    );
  }
}
