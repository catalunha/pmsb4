import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/components/logout_button.dart';
import 'package:pmsb4/routes.dart';

class HomePageDS extends StatelessWidget {
  HomePageDS({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Logout'),
            trailing: LogoutButton(),
          ),
          // ListTile(
          //   title: Text('Counter Page'),
          //   onTap: () {
          //     // Navigator.pushNamed(context, Routes.counter);
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (_) => CounterPage(
          //           title: 'Valor',
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // ListTile(
          //   title: Text('Profile Page'),
          //   onTap: () {
          //     // Navigator.pushNamed(context, Routes.perfil);
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => ProfilePage(),
          //       ),
          //     );
          //   },
          // ),
          // ListTile(
          //   title: Text('Collection Page'),
          //   onTap: () {
          //     Navigator.pushNamed(context, Routes.collection);
          //   },
          // ),
          ListTile(
            title: Text('KanbanBoard Page'),
            onTap: () {
              Navigator.pushNamed(context, Routes.kanbanBoardPage);
            },
          ),
        ],
      ),
    );
  }
}
