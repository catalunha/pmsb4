import 'package:flutter/material.dart';

class KanbanCardCreateDS extends StatefulWidget {
  final Function(String, String) onCreate;

  const KanbanCardCreateDS({Key key, this.onCreate}) : super(key: key);

  @override
  _KanbanCardCreateDSState createState() => _KanbanCardCreateDSState();
}

class _KanbanCardCreateDSState extends State<KanbanCardCreateDS> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Text('KanbanCardCreateDS'),
    );
  }
}
