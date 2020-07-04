import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class FeedCardUpdateDS extends StatefulWidget {
  final String description;
  final String link;
  final Function(String, String) onUpdate;

  const FeedCardUpdateDS({Key key, this.description, this.link, this.onUpdate})
      : super(key: key);

  @override
  _FeedCardUpdateDSState createState() => _FeedCardUpdateDSState();
}

class _FeedCardUpdateDSState extends State<FeedCardUpdateDS> {
  static final formKey = GlobalKey<FormState>();
  String _description;
  String _link;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scaffold(
        appBar: AppBar(
          title: Text('FeedCardCRUD Atualizar'),
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
              child: Text('Atualizar'),
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
      widget.onUpdate(_description, _link);
    } else {
      setState(() {});
    }
  }
}
