import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class KanbanCardCreateOrUpdateTitleDescriptionDS extends StatefulWidget {
  final bool isCreate;
  final String title;
  final String description;
  final Function(String, String) onCreate;

  final Function(String, String, bool, bool) onUpdate;

  const KanbanCardCreateOrUpdateTitleDescriptionDS({
    Key key,
    this.isCreate,
    this.title,
    this.description,
    this.onCreate,
    this.onUpdate,
  }) : super(key: key);
  @override
  _KanbanCardCreateOrUpdateTitleDescriptionDSState createState() =>
      _KanbanCardCreateOrUpdateTitleDescriptionDSState();
}

class _KanbanCardCreateOrUpdateTitleDescriptionDSState
    extends State<KanbanCardCreateOrUpdateTitleDescriptionDS> {
  static final formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  _KanbanCardCreateOrUpdateTitleDescriptionDSState();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scaffold(
        appBar: AppBar(
          title: widget.isCreate ? Text('Criar') : Text('Editar'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: form(),
        ),
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
            title: 'Titulo do cartão',
            initialValue: widget.title,
            onSaved2: (value) => _title = value,
          ),
          InputText(
            title: 'Descrição do cartão',
            initialValue: widget.description,
            onSaved2: (value) => _description = value,
          ),
          ListTile(
            title: Center(
              child: widget.isCreate ? Text('Criar') : Text('Atualizar'),
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
      if (widget.isCreate) {
        widget.onCreate(_title, _description);
      } else {
        widget.onUpdate(_title, _description, null, null);
      }
    } else {
      setState(() {});
    }
  }
}
