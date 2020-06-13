import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/containers/user/home_page.dart';
// import 'package:pmsb4/app_store.dart';
import 'package:pmsb4/middlewares/auth_middleware.dart';
import 'package:pmsb4/reducers/app_reducer.dart';
import 'package:pmsb4/routes.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key})
      : store = Store<AppState>(
          appReducer,
          initialState: AppState.initial(),
          middleware: createAuthMiddleware(),
          // middleware: []..addAll(createAuthMiddleware())..addAll(LoggingMiddleware.printer()),
        ),
        super(key: key){
          // any initialization
          // store.dispacth()
        }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      // store: appStore,
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          Routes.home: (context) {
            return HomePage();
          }
        },
      ),
    );
  }
}
