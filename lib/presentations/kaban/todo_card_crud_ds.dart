import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class TodoCardCRUDDS extends StatefulWidget {
  final bool isCreate;
  final String title;
  final Function(String) onCreateOrUpdate;

  const TodoCardCRUDDS(
      {Key key, this.isCreate, this.title, this.onCreateOrUpdate})
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
        title: widget.isCreate
            ? Text('TodoCardCRUD Criar')
            : Text('TodoCardCRUD Editar'),
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
            title: 'Titulo do todo',
            initialValue: widget.title,
            onSaved2: (value) => _title = value,
          ),
          ListTile(
            title: Center(
              child: widget.isCreate ? Text('Criar') : Text('Editar'),
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
