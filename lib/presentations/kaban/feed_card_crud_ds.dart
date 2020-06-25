import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class FeedCardCRUDDS extends StatefulWidget {
  final bool isEditing;
  final String description;
  final String link;
  final Function(String, String) onCreateOrUpdate;

  const FeedCardCRUDDS(
      {Key key,
      this.isEditing,
      this.description,
      this.link,
      this.onCreateOrUpdate})
      : super(key: key);
  @override
  _FeedCardCRUDDSState createState() => _FeedCardCRUDDSState();
}

class _FeedCardCRUDDSState extends State<FeedCardCRUDDS> {
  static final formKey = GlobalKey<FormState>();
  String _description;
  String _link;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditing
            ? Text('FeedCardCRUD Editar')
            : Text('FeedCardCRUD Criar'),
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
            title: 'description',
            initialValue: widget.description,
            onSaved2: (value) => _description = value,
          ),
          InputText(
            title: 'link',
            initialValue: widget.link,
            onSaved2: (value) => _link = value,
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
      widget.onCreateOrUpdate(_description, _link);
    } else {
      setState(() {});
    }
  }
}
