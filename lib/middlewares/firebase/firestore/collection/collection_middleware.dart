import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/middlewares/firebase/firestore/collection/collection_model.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseFirestoreCollectionMiddleware() {
  return [
    TypedMiddleware<AppState, CollectionStreamDocsAction>(
        _collectionStreamDocsAction()),
  ];
}

Middleware<AppState> _collectionStreamDocsAction() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    print('_collectionStreamDocsAction');
    Firestore firestore = Firestore.instance;
    final streamDocs =
        firestore.collection(CollectionModel.collection).snapshots();
    final listDocs = streamDocs.map((snapDocs) => snapDocs.documents
        .map((doc) => CollectionModel(doc.documentID).fromFirestore(doc.data))
        .toList());
    listDocs.listen((List<CollectionModel> listCollectionModel) {
      print('listCollectionModel: ${listCollectionModel.length}');
      store.dispatch(CollectionListDocsAction(listCollectionModel: listCollectionModel));
    });
    next(action);
  };
}
