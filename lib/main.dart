import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/logged_action.dart';
import 'package:pmsb4/containers/home/home_page.dart';
import 'package:pmsb4/containers/kanban/kanban_board_page.dart';
import 'package:pmsb4/containers/kanban/kanban_card_crud.dart';
import 'package:pmsb4/containers/kanban/kanban_card_page.dart';
import 'package:pmsb4/containers/kanban/team_board.dart';
import 'package:pmsb4/containers/logged/profile_page.dart';
import 'package:pmsb4/containers/logged/profile_update.dart';
import 'package:pmsb4/middlewares/firebase/authentication_middleware.dart';
import 'package:pmsb4/middlewares/firebase/kanban_board_middleware.dart';
import 'package:pmsb4/middlewares/firebase/kanban_card_middleware.dart';
import 'package:pmsb4/middlewares/firebase/storage_middleware.dart';
import 'package:pmsb4/middlewares/firebase/user_middleware.dart';
import 'package:pmsb4/plataform/resources.dart';

import 'package:pmsb4/reducers/app_reducer.dart';
import 'package:pmsb4/routes.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/types_states.dart';
import 'package:redux/redux.dart';

Store<AppState> _store = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: []
    ..addAll(firebaseAuthenticationMiddleware())
    ..addAll(firebaseStorageMiddleware())
    ..addAll(firebaseFirestoreUserMiddleware())
    ..addAll(firebaseFirestoreKanbanBoardMiddleware())
    ..addAll(firebaseFirestoreKanbanCardMiddleware()),
  // middleware: []..addAll(createAuthMiddleware())..addAll(LoggingMiddleware.printer()),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key})
      : store = _store,
        super(key: key) {
    // store.dispatch(AuthenticationStatusLoggedAction(
    //     loggedAuthenticationStatus: AuthenticationStatus.unInitialized));
    // store.dispatch(OnAuthStateChangedLoggedAction());
  }

  @override
  Widget build(BuildContext context) {
    Recursos.initialize(Theme.of(context).platform);

    return StoreProvider<AppState>(
      // store: appStore,
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PMSB4',
        theme: ThemeData.dark(),
        navigatorKey: Keys.navKey,
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) {
            return HomePage();
          },
          Routes.profile: (context) {
            return ProfilePage();
          },
          Routes.profileUpdate: (context) {
            return ProfileUpdate();
          },
          Routes.teamBoard: (context) {
            return TeamBoard();
          },
          Routes.kanbanBoardPage: (context) {
            return KanbanBoardPage();
          },
          Routes.kanbanCardPage: (context) {
            return KanbanCardPage();
          },
          Routes.kanbanCardCRUD: (context) {
            return KanbanCardCRUD();
          },
        },
      ),
    );
  }
}
