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
    this.photoUrl = 'aa',
    this.updateProfile,
  }) : super(key: key);
  @override
  ProfileUpdateDSState createState() {
    return ProfileUpdateDSState();
  }
}

class ProfileUpdateDSState extends State<ProfileUpdateDS> {
  final formKey = GlobalKey<FormState>();
  final displayNameController = TextEditingController();
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.updateProfile(this.displayNameController.text, '');
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: <Widget>[
                InputField(
                  title: 'Display Name',
                  controller: displayNameController,
                  initialValue: widget.displayName,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: ListTile(
              title: Center(
                child: Text('Atualizar'),
              ),
              onTap: () {
                validateData();
              },
            ),
          ),
        ],
      ),
    );
  }
}
