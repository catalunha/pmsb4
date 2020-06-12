import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/app_store.dart';
import 'package:pmsb4/containers/counter/counter.dart';
import 'package:pmsb4/routes.dart';
import 'package:pmsb4/states/app_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: appStore,
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          Routes.homePage: (context){
            return HomePage(title: 'Counter with Redux');
          }
        },
      ),
    );
  }
}
