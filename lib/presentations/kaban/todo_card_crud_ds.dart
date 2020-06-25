import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class TodoCardCRUDDS extends StatefulWidget {
  final bool isEditing;
  final String title;
  final Function(String) onCreateOrUpdate;

  const TodoCardCRUDDS(
      {Key key, this.isEditing, this.title, this.onCreateOrUpdate})
      : super(key: key);

  @override
  _TodoCardCRUDDSState createState() => _TodoCardCRUDDSState();
}

class _TodoCardCRUDDSState extends State<TodoCardCRUDDS> {
  static final formKey = GlobalKey<FormState>();
  String _title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditing
            ? Text('TodoCardCRUD Editar')
            : Text('TodoCardCRUD Criar'),
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
        shrinkWrap: true,
        children: [
          InputText(
            title: 'Titulo do quadro',
            initialValue: widget.title,
            onSaved2: (value) => _title = value,
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
      widget.onCreateOrUpdate(_title);
    } else {
      setState(() {});
    }
  }
}
