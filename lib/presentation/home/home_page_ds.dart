import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/container/components/logout_button.dart';
import 'package:pmsb4/container/counter/counter_page.dart';
import 'package:pmsb4/container/user/perfil_page.dart';


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
          ListTile(
            title: Text('Perfil Page'),
            onTap: () {
              // Navigator.pushNamed(context, Routes.perfil);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PerfilPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Counter Page'),
            onTap: () {
              // Navigator.pushNamed(context, Routes.counter);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CounterPage(
                    title: 'Valor',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
