import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/routes.dart';

class ProfilePageDS extends StatelessWidget {
  final String uid;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoUrl;
  ProfilePageDS(
      {Key key,
      this.uid,
      this.displayName,
      this.email,
      this.phoneNumber,
      this.photoUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile do Usuario'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              minRadius: 30,
              maxRadius: 30,
              // backgroundImage: NetworkImage(photoUrl),
              child: ClipOval(
                child: Center(
                  child: Uri.parse(photoUrl).isAbsolute
                      ? Image.network(photoUrl)
                      : Icon(Icons.chat),
                ),
              ),
            ),
            title: Text('FirebaseUser'),
            subtitle: Text(
                'uid:$uid\ndisplayName:$displayName\nemail:$email\nphoneNumber:$phoneNumber\nphotoUrl:$photoUrl'),
            onTap: () {
              Navigator.pushNamed(context, Routes.profileUpdate);
            },
          ),
        ],
      ),
    );
  }
}
