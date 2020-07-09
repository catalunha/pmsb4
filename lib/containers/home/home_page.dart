import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/logged_action.dart';
import 'package:pmsb4/containers/kanban/kanban_board_page.dart';
import 'package:pmsb4/containers/logged/login_page.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/types_states.dart';
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
          // return HomePageDS();
          return KanbanBoardPage();
        } else {
          return LoginPage();
        }
      },
      onInit: (store) {
        store.dispatch(AuthenticationStatusLoggedAction(
            loggedAuthenticationStatus: AuthenticationStatus.unInitialized));
        store.dispatch(OnAuthStateChangedLoggedAction());
      },
    );
  }
}
