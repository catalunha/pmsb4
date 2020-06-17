import 'package:pmsb4/model/collection/collection_model.dart';

class CollectionAction {}

// +++ Actions atendidas pelo CollectionReducer
class CollectionListDocsAction extends CollectionAction {
  final List<CollectionModel> listCollectionModel;

  CollectionListDocsAction({this.listCollectionModel});
}

class CollectionCurrentDocAction extends CollectionAction {
  final int index;

  CollectionCurrentDocAction({this.index});
}

// +++ Actions atendidas pelo firebaseFirestoreCollectionMiddleware
class CollectionAddDocAction extends CollectionAction {
  final CollectionModel collectionModel;

  CollectionAddDocAction({this.collectionModel});
}

class CollectionStreamDocsAction extends CollectionAction {}

class CollectionUpdateDocAction extends CollectionAction {
  final CollectionModel collectionModel;
  CollectionUpdateDocAction({this.collectionModel});
}

class CollectionDeleteDocsAction extends CollectionAction {
  final String id;

  CollectionDeleteDocsAction({this.id});
}
