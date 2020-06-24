import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseFirestoreKanbanCardMiddleware() {
  return [
    TypedMiddleware<AppState, StreamKanbanCardAction>(
        _streamDocsKanbanCardAction()),
    TypedMiddleware<AppState, UpdateKanbanCardAction>(
        _updateDocKanbanCardAction()),
    TypedMiddleware<AppState, DeleteKanbanCardAction>(
        _deleteDocKanbanCardAction()),
    TypedMiddleware<AppState, AddKanbanCardAction>(_addDocKanbanCardAction()),
  ];
}

void Function(Store<AppState> store, StreamKanbanCardAction action,
    NextDispatcher next) _streamDocsKanbanCardAction() {
  return (store, action, next) {
    print('_streamDocsKanbanCardAction...');
    Firestore firestore = Firestore.instance;
    Stream<QuerySnapshot> streamDocs;
    KanbanCardFilter currentFilter =
        store.state.kanbanCardState.kanbanCardFilter;
    if (currentFilter == KanbanCardFilter.all) {
      streamDocs = firestore
          .collection(KanbanCardModel.collection)
          // .where('active', isEqualTo: true)
          // .where('author.id', isEqualTo: store.state.userState.firebaseUser.uid)
          .snapshots();
    } else if (currentFilter == KanbanCardFilter.active) {
      streamDocs = firestore
          .collection(KanbanCardModel.collection)
          .where('active', isEqualTo: true)
          // .where('author.id', isEqualTo: store.state.userState.firebaseUser.uid)
          .snapshots();
    } else if (currentFilter == KanbanCardFilter.inactive) {
      streamDocs = firestore
          .collection(KanbanCardModel.collection)
          .where('active', isEqualTo: false)
          // .where('author.id', isEqualTo: store.state.userState.firebaseUser.uid)
          .snapshots();
    } 
    final listDocs = streamDocs.map((snapDocs) => snapDocs.documents
        .map((doc) => KanbanCardModel(doc.documentID).fromFirestore(doc.data))
        .toList());
    listDocs.listen((List<KanbanCardModel> allKanbanCardModel) {
      print('allKanbanCardModel: ${allKanbanCardModel.length}');
      store.dispatch(
          AllKanbanCardModelAction(allKanbanCardModel: allKanbanCardModel));
      store.dispatch(UpdateKanbanCardFilterAction());
    });
    next(action);
  };
}

void Function(Store<AppState> store, UpdateKanbanCardAction action,
    NextDispatcher next) _updateDocKanbanCardAction() {
  return (store, action, next) {
    print('_updateDocKanbanCardAction...');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanCardModel.collection)
        .document(action.kanbanCardModel.id)
        .updateData(action.kanbanCardModel.toFirestore());
    next(action);
  };
}

void Function(Store<AppState> store, DeleteKanbanCardAction action,
    NextDispatcher next) _deleteDocKanbanCardAction() {
  return (store, action, next) {
    print('_deleteDocKanbanCardAction...');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanCardModel.collection)
        .document(action.id)
        .delete();
    next(action);
  };
}

void Function(
        Store<AppState> store, AddKanbanCardAction action, NextDispatcher next)
    _addDocKanbanCardAction() {
  return (store, action, next) {
    print('_addDocKanbanCardAction...');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanCardModel.collection)
        .document()
        .setData(action.kanbanCardModel.toFirestore());
    next(action);
  };
}
