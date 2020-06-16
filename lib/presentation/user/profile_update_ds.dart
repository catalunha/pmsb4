import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          // TextFormField(
          //   initialValue: widget.photoUrl,
          //   decoration: InputDecoration(
          //     labelText: 'PhotoUrl:',
          //   ),
          //   onSaved: (value) => _photoUrl = value,
          // ),
          ListTile(
            title: Text('Selecione a foto'),
            trailing: Icon(Icons.file_download),
            onTap: () async {
              await _selectFile().then((filePath) {
                print(filePath);
                _photoUrl = filePath;
                setState(() {
                  
                });
              });
            },
          ),
          CircleAvatar(
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

Future<String> _selectFile() async {
  try {
    var filePath = await FilePicker.getFilePath(type: FileType.image);
    if (filePath != null) {
      return filePath;
    }
  } catch (e) {}
  return null;
}
