import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String title;
  final String initialValue;
  final Function(String) onSaved2;
  const InputText({Key key, this.title, this.initialValue, this.onSaved2})
      : super(key: key);
  @override
  InputTextState createState() {
    return InputTextState();
  }
}

class InputTextState extends State<InputText> {
  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: widget.title,
        ),
        initialValue: widget.initialValue ?? '',
        onSaved: widget.onSaved2);
  }
}
