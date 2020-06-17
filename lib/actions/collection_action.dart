import 'package:pmsb4/middlewares/firebase/firestore/collection/collection_model.dart';

class CollectionAction {}

// +++ Actions atendidas pelo CollectionReducer
class CollectionListDocsAction extends CollectionAction {
  final List<CollectionModel> listCollectionModel;

  CollectionListDocsAction({this.listCollectionModel});
}
class CollectionCurrentDocAction extends CollectionAction{
  final int index;

  CollectionCurrentDocAction({this.index});
}

// +++ Actions atendidas pelo firebaseFirestoreCollectionMiddleware
class CollectionStreamDocsAction extends CollectionAction {}

class CollectionAddDocAction extends CollectionAction {
  final CollectionModel collectionModel;

  CollectionAddDocAction({this.collectionModel});
}

class CollectionDeleteDocsAction extends CollectionAction {
  final List<CollectionModel> listCollectionModel;

  CollectionDeleteDocsAction({this.listCollectionModel});
}

class CollectionUpdateDocAction extends CollectionAction {
  final CollectionModel collectionModel;

  CollectionUpdateDocAction({this.collectionModel});
}
