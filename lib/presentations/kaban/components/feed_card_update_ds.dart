import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
