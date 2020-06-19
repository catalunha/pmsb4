import 'dart:io';
import 'package:pmsb4/plataform/incompatible/incompatible.dart'
    show FilePicker, FileType;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pmsb4/plataform/resources.dart';

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
          title: Text('Profile update ${Recursos.instance.plataforma}'),
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
          // TextFormField(
          //   initialValue: widget.photoUrl,
          //   decoration: InputDecoration(
          //     labelText: 'PhotoUrl:',
          //   ),
          //   onSaved: (value) => _photoUrl = value,
          // ),
          Recursos.instance.plataforma == 'android'
              ? ListTile(
                  title: Text('Selecione a foto'),
                  trailing: Icon(Icons.file_download),
                  onTap: () async {
                    await _selectFile().then((filePath) {
                      print(filePath);
                      _photoUrl = filePath;
                      setState(() {});
                    });
                  },
                )
              : Container(),
          Recursos.instance.plataforma == 'android'
              ? CircleAvatar(
                  minRadius: 100,
                  maxRadius: 100,
                  // backgroundImage: NetworkImage(photoUrl),
                  child: ClipOval(
                    child: Center(
                      child: _photoUrl != null
                          ? Image.file(File(_photoUrl))
                          : Icon(Icons.chat),
                    ),
                  ),
                )
              : Container(),
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

Future<String> _selectFile() async {
  try {
    var filePath = await FilePicker.getFilePath(type: FileType.image);
    if (filePath != null) {
      return filePath;
    }
  } catch (e) {}
  return null;
}
