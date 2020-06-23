import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/containers/collection/collection_page.dart';
import 'package:pmsb4/containers/collection/collection_update.dart';
import 'package:pmsb4/containers/counter/counter_page.dart';
import 'package:pmsb4/containers/home/home_page.dart';
import 'package:pmsb4/containers/kanban/kanban_board_page.dart';
import 'package:pmsb4/containers/user/profile_page.dart';
import 'package:pmsb4/containers/user/profile_update.dart';
import 'package:pmsb4/middlewares/firebase/authentication_middleware.dart';
import 'package:pmsb4/middlewares/firebase/collection_middleware.dart';
import 'package:pmsb4/middlewares/firebase/kanban_board_middleware.dart';
import 'package:pmsb4/middlewares/firebase/storage_middleware.dart';
import 'package:pmsb4/plataform/resources.dart';

import 'package:pmsb4/reducers/app_reducer.dart';
import 'package:pmsb4/routes.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:redux/redux.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

Store<AppState> _store = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: []
    ..addAll(firebaseAuthenticationMiddleware())
    ..addAll(firebaseStorageMiddleware())
    ..addAll(firebaseFirestoreCollectionMiddleware())
    ..addAll(firebaseFirestoreKanbanBoardMiddleware()),
  // middleware: []..addAll(createAuthMiddleware())..addAll(LoggingMiddleware.printer()),
);

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key})
      : store = _store,
        super(key: key) {
    store.dispatch(UserAuthenticationStatusAction(
        authenticationStatus: AuthenticationStatus.unInitialized));
    store.dispatch(UserOnAuthStateChangedAction());
  }

  @override
  Widget build(BuildContext context) {
    Recursos.initialize(Theme.of(context).platform);

    return StoreProvider<AppState>(
      // store: appStore,
      store: store,
      child: MaterialApp(
        title: 'PMSB4',
        navigatorKey: Keys.navKey,
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) {
            return HomePage();
          },
          Routes.counter: (context) {
            return CounterPage();
          },
          Routes.profile: (context) {
            return ProfilePage();
          },
          Routes.profileUpdate: (context) {
            return ProfileUpdate();
          },
          Routes.collection: (context) {
            return CollectionPage();
          },
          Routes.collectionUpdate: (context) {
            return CollectionUpdate();
          },
          Routes.kanbanBoard: (context) {
            return KanbanBoardPage();
          },
        },
      ),
    );
  }
}
