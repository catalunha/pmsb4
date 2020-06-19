import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputMultiline extends StatefulWidget {
  final String title;
  final String initialValue;
  final Function(String) onSaved2;
  const InputMultiline({Key key, this.title, this.initialValue, this.onSaved2})
      : super(key: key);
  @override
  InputMultilineState createState() {
    return InputMultilineState();
  }
}

class InputMultilineState extends State<InputMultiline> {
  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: widget.title,
        ),
        initialValue: widget.initialValue ?? '',
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onSaved: widget.onSaved2);
  }
}
