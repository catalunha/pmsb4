import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/middlewares/firebase/firestore/colecao/colecao_model.dart';

class ColecaoUpdateDS extends StatefulWidget {
  final int index;
  final ColecaoModel colecaoModel;

  const ColecaoUpdateDS({
    Key key,
    this.index,
    this.colecaoModel,
  }) : super(key: key);
  @override
  ColecaoUpdateDSState createState() {
    return ColecaoUpdateDSState();
  }
}

class ColecaoUpdateDSState extends State<ColecaoUpdateDS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Colecao update'),
      ),
      body: Text('item ${widget.index} ${widget?.colecaoModel?.id}'),
    );
  }
}
