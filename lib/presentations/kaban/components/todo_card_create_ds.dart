import 'package:flutter/material.dart';

class TodoCardCreateDS extends StatefulWidget {
  final Function(String) onCreate;

  const TodoCardCreateDS({Key key, this.onCreate}) : super(key: key);

  @override
  _TodoCardCreateDSState createState() => _TodoCardCreateDSState();
}

class _TodoCardCreateDSState extends State<TodoCardCreateDS> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Text('TodoCardCreateDS'),
    );
  }
}
