import 'package:flutter/material.dart';

class TodoCardUpdateDS extends StatefulWidget {
  final String title;
  final Function(String) onUpdate;

  const TodoCardUpdateDS({Key key, this.title, this.onUpdate})
      : super(key: key);

  @override
  _TodoCardUpdateDSState createState() => _TodoCardUpdateDSState();
}

class _TodoCardUpdateDSState extends State<TodoCardUpdateDS> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
