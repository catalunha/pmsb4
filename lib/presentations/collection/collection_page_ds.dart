import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/collection/collection_update.dart';
import 'package:pmsb4/models/collection_model.dart';

class CollectionPageDS extends StatelessWidget {
  final List<CollectionModel> filteredCollectionModel;
  final Function(bool) filter;
  const CollectionPageDS({
    Key key,
    this.filteredCollectionModel,
    this.filter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collection...'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box),
            onPressed: () {
              filter(true);
            },
          ),
          IconButton(
            icon: Icon(Icons.check_box_outline_blank),
            onPressed: () {
              filter(false);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredCollectionModel.length,
        itemBuilder: (BuildContext context, int index) {
          final collection = filteredCollectionModel[index];
          return ListTile(
            title: Text(collection.letter),
            subtitle: Text(collection.id),
            leading: Checkbox(
                value: collection.check,
                tristate: true,
                activeColor: Colors.green,
                onChanged: (bool newValue) {
                  collection.check = newValue;
                }),
            trailing: Checkbox(
                value: collection.check,
                tristate: true,
                activeColor: Colors.green,
                onChanged: (bool newValue) {}),
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
        onPressed: () {
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
