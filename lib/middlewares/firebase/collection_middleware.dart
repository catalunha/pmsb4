import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/models/collection_model.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseFirestoreCollectionMiddleware() {
  return [
    TypedMiddleware<AppState, CollectionStreamDocsAction>(
        _collectionStreamDocsAction()),
    TypedMiddleware<AppState, CollectionUpdateDocAction>(
        _collectionUpdateDocAction()),
    TypedMiddleware<AppState, CollectionDeleteDocsAction>(
        _collectionDeleteDocsAction()),
    TypedMiddleware<AppState, CollectionAddDocAction>(
        _collectionAddDocAction()),
  ];
}

void Function(
  Store<AppState> store,
  CollectionStreamDocsAction action,
  NextDispatcher next,
) _collectionStreamDocsAction() {
  return (store, action, next) async {
    print('_collectionStreamDocsAction');
    Firestore firestore = Firestore.instance;
    final streamDocs =
        firestore.collection(CollectionModel.collection).snapshots();
    final listDocs = streamDocs.map((snapDocs) => snapDocs.documents
        .map((doc) => CollectionModel(doc.documentID).fromFirestore(doc.data))
        .toList());
    listDocs.listen((List<CollectionModel> listCollectionModel) {
      print('listCollectionModel: ${listCollectionModel.length}');
      store.dispatch(
          CollectionListDocsAction(listCollectionModel: listCollectionModel));
    });
    next(action);
  };
}

void Function(
  Store<AppState> store,
  CollectionUpdateDocAction action,
  NextDispatcher next,
) _collectionUpdateDocAction() {
  return (store, action, next) {
    print('_collectionUpdateDocAction');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(CollectionModel.collection)
        .document(action.collectionModel.id)
        .updateData(action.collectionModel.toFirestore());
    next(action);
  };
}

void Function(
  Store<AppState> store,
  CollectionDeleteDocsAction action,
  NextDispatcher next,
) _collectionDeleteDocsAction() {
  return (store, action, next) {
    print('_collectionDeleteDocsAction');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(CollectionModel.collection)
        .document(action.id)
        .delete();
    next(action);
  };
}
void Function(
  Store<AppState> store,
  CollectionAddDocAction action,
  NextDispatcher next,
) _collectionAddDocAction(){
  return (store, action, next) {
    print('_collectionAddDocAction');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(CollectionModel.collection)
        .document()
        .setData(action.collectionModel.toFirestore());
    next(action);
  };
}