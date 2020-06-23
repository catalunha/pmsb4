import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class KanbanBoardCRUDDS extends StatefulWidget {
  final bool isEditing;
  final String title;
  final bool public;

  final Function(String, bool) add;

  const KanbanBoardCRUDDS({
    Key key,
    this.isEditing,
    this.title,
    this.public,
    this.add,
  }) : super(key: key);
  @override
  KanbanBoardCRUDDSState createState() {
    return KanbanBoardCRUDDSState(public);
  }
}

class KanbanBoardCRUDDSState extends State<KanbanBoardCRUDDS> {
  static final formKey = GlobalKey<FormState>();
  String _title;
  bool _public;

  KanbanBoardCRUDDSState(this._public);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditing
            ? Text('Kanban Board Editar')
            : Text('Kanban Board Criar'),
      ),
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
        children: [
          InputText(
            title: 'Titulo do quadro',
            initialValue: widget.title,
            onSaved2: (value) => _title = value,
          ),
           ListTile(
            title: Text('Marcado'),
            trailing: Checkbox(
                // +++
                // 1) Ou usa assim true||false never null
                value: _public ?? false,
                // 2) Ou assim true|false|null
                // value: _public,
                // tristate: true,
                // ---
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    _public = value;
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
        ],
      ),
    );
  }

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (widget.isEditing) {
        // widget.update(letter, _check);
      } else {
        widget.add(_title,_public);
      }
    } else {
      setState(() {});
    }
  }
}
