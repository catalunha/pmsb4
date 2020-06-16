import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/middlewares/firebase/firestore/colecao/colecao_model.dart';

class ColecaoPageDS extends StatelessWidget {
  final List<ColecaoModel> listColecaoModel;

  const ColecaoPageDS({
    Key key,
    this.listColecaoModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colecao'),
      ),
      body: ListView.builder(
          itemCount: listColecaoModel.length,
          itemBuilder: (BuildContext context, int index) {
            final colecao = listColecaoModel[index];
            return ListTile(
              title: Text(colecao.letter),
              subtitle: Text(colecao.id),
            );
          }),
    );
  }
}
