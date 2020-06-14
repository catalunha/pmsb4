import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PerfilPageDS extends StatelessWidget {
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoUrl;
  PerfilPageDS(
      {Key key, this.displayName, this.email, this.phoneNumber, this.photoUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuario'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('FirebaseUser'),
            subtitle: Text('displayName:$displayName\nemail:$email\nphoneNumber:$phoneNumber\nphotoUrl:$photoUrl'),
          )
        ],
      ),
    );
  }
}
