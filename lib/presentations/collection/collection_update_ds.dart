import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class CollectionUpdateDS extends StatefulWidget {
  final bool isEditing;
  final String letter;
  final bool check;
  final Function(String, bool) create;
  final Function(String, bool) update;
  final Function delete;
  const CollectionUpdateDS({
    Key key,
    this.letter,
    this.check,
    this.update,
    this.delete,
    this.isEditing,
    this.create,
  }) : super(key: key);
  @override
  CollectionUpdateDSState createState() {
    return CollectionUpdateDSState(check);
  }
}

class CollectionUpdateDSState extends State<CollectionUpdateDS> {
  static final formKey = GlobalKey<FormState>();

  String letter;
  bool _check;

  CollectionUpdateDSState(this._check);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditing
            ? Text('Collection editar')
            : Text('Collection criar'),
      ),
      // body: Text('item ${widget.index} ${widget?.collectionModel?.id}'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: form(),
      ),
    );
  }

  Widget form() {
    // _check = widget.check;
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          // TextFormField(
          //   initialValue: widget.letter,
          //   decoration: InputDecoration(labelText: 'Letra'),
          //   onSaved: (value) => letter = value,
          // ),
          InputText(
            title: 'Letra',
            initialValue: widget.letter,
            onSaved2: (value) => letter = value,
          ),
          ListTile(
            title: Text('Marcado'),
            trailing: Checkbox(
                // +++
                // 1) Ou usa assim true||false never null
                // value: _check ?? false,
                // 2) Ou assim true|false|null
                value: _check,
                tristate: true,
                // ---
                activeColor: Colors.green,
                onChanged: (bool newValue) {
                  setState(() {
                    _check = newValue;
                  });
                }),
          ),
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
        widget.update(letter, _check);
      } else {
        widget.create(letter, _check);
      }
    } else {
      setState(() {});
    }
  }
}
