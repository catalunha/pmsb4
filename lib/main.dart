import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/container/collection/collection_page.dart';
import 'package:pmsb4/container/collection/collection_update.dart';
import 'package:pmsb4/container/counter/counter_page.dart';
import 'package:pmsb4/container/home/home_page.dart';
import 'package:pmsb4/container/user/profile_page.dart';
import 'package:pmsb4/container/user/profile_update.dart';
import 'package:pmsb4/middlewares/firebase/authentication/authentication_middleware.dart';
import 'package:pmsb4/middlewares/firebase/firestore/collection/collection_middleware.dart';

import 'package:pmsb4/middlewares/storage/storage_middleware.dart';
import 'package:pmsb4/reducers/app_reducer.dart';
import 'package:pmsb4/routes.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:redux/redux.dart';

void main() {
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
    ..addAll(firebaseFirestoreCollectionMiddleware()),
  // middleware: []..addAll(createAuthMiddleware())..addAll(LoggingMiddleware.printer()),
);

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key})
      : store = _store,
        super(key: key) {
    // TODO: Resolver esta conferencia se usuario ja esta logado.
    // store.dispatch(UserOnAuthStateChangedAction());
    store.dispatch(UserAuthenticationStatusAction(
        authenticationStatus: AuthenticationStatus.unInitialized));
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      // store: appStore,
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
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
        },
      ),
    );
  }
}
