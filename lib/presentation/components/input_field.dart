import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String initialValue;

  const InputField({Key key, this.title, this.controller, this.initialValue}) : super(key: key);
  @override
  InputFieldState createState() {
    return InputFieldState();
  }
}

class InputFieldState extends State<InputField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.title,
      ),
    );
  }
}
