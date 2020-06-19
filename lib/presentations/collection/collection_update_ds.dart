import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class CollectionUpdateDS extends StatefulWidget {
  final bool isEditing;
  final String letter;
  final Function(String) add;
  final Function(String) update;
  final Function delete;
  const CollectionUpdateDS({
    Key key,
    this.letter,
    this.update,
    this.delete,
    this.isEditing,
    this.add,
  }) : super(key: key);
  @override
  CollectionUpdateDSState createState() {
    return CollectionUpdateDSState();
  }
}

class CollectionUpdateDSState extends State<CollectionUpdateDS> {
  static final formKey = GlobalKey<FormState>();

  String letter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditing ? Text('Collection editar'):Text('Collection criar'),
      ),
      // body: Text('item ${widget.index} ${widget?.collectionModel?.id}'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: form(),
      ),
    );
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          // TextFormField(
          //   initialValue: widget.letter,
          //   decoration: InputDecoration(labelText: 'Letra'),
          //   onSaved: (value) => letter = value,
          // ),
          InputText(title: 'Letra',initialValue: widget.letter,onSaved2: (value) => letter = value,),
          ListTile(
            title: Center(
              child: widget.isEditing ? Text('Atualizar') : Text('Criar'),
            ),
            onTap: () {
              validateData();
              Navigator.pop(context);
            },
          ),
          widget.isEditing
              ? ListTile(
                  title: Center(
                    child: Text('Delete'),
                  ),
                  onTap: () {
                    widget.delete();
                    Navigator.pop(context);
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (widget.isEditing) {
        widget.update(letter);
      } else {
        widget.add(letter);
      }
    } else {
      setState(() {});
    }
  }
}
