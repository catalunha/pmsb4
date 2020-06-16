import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pmsb4/presentation/components/input_field.dart';

class ProfileUpdateDS extends StatefulWidget {
  final String displayName;
  final String photoUrl;
  final Function(String, String) updateProfile;

  const ProfileUpdateDS({
    Key key,
    this.displayName,
    this.photoUrl,
    this.updateProfile,
  }) : super(key: key);
  @override
  ProfileUpdateDSState createState() {
    return ProfileUpdateDSState();
  }
}

class ProfileUpdateDSState extends State<ProfileUpdateDS> {
  static final formKey = GlobalKey<FormState>();
  String _displayName;
  String _photoUrl;

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.updateProfile(_displayName, _photoUrl);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile update'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: form(),
        ));
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            initialValue: widget.displayName,
            decoration: InputDecoration(
              labelText: 'UserName:',
            ),
            onSaved: (value) => _displayName = value,
          ),
          TextFormField(
            initialValue: widget.photoUrl,
            decoration: InputDecoration(
              labelText: 'PhotoUrl:',
            ),
            onSaved: (value) => _photoUrl = value,
          ),
          ListTile(
            title: Center(child: Text('Atualizar')),
            onTap: () {
              validateData();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
