import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/middlewares/firebase/firestore/collection/collection_model.dart';

class CollectionUpdateDS extends StatefulWidget {
  final int index;
  final CollectionModel collectionModel;

  const CollectionUpdateDS({
    Key key,
    this.index,
    this.collectionModel,
  }) : super(key: key);
  @override
  CollectionUpdateDSState createState() {
    return CollectionUpdateDSState();
  }
}

class CollectionUpdateDSState extends State<CollectionUpdateDS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Collection update'),
      ),
      body: Text('item ${widget.index} ${widget?.collectionModel?.id}'),
    );
  }
}
