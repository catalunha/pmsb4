import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/collection/collection_update.dart';
import 'package:pmsb4/models/collection_model.dart';

class CollectionPageDS extends StatelessWidget {
  final List<CollectionModel> listCollectionModel;

  const CollectionPageDS({
    Key key,
    this.listCollectionModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collection...'),
      ),
      body: ListView.builder(
        itemCount: listCollectionModel.length,
        itemBuilder: (BuildContext context, int index) {
          final collection = listCollectionModel[index];
          return ListTile(
            title: Text(collection.letter),
            subtitle: Text(collection.id),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CollectionUpdate(
                    index: index,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: (){
                        Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CollectionUpdate(
                    index: null,
                  ),
                ),
              );
        },
      ),
    );
  }
}