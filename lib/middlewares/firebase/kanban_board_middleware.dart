import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseFirestoreKanbanBoardMiddleware() {
  return [
    TypedMiddleware<AppState, StreamKanbanBoardAction>(
        _streamDocsKanbanBoardAction()),
    TypedMiddleware<AppState, UpdateKanbanBoardAction>(
        _updateDocKanbanBoardAction()),
    TypedMiddleware<AppState, DeleteKanbanBoardAction>(
        _deleteDocKanbanBoardAction()),
    TypedMiddleware<AppState, AddKanbanBoardAction>(_addDocKanbanBoardAction()),
  ];
}

void Function(Store<AppState> store, StreamKanbanBoardAction action,
    NextDispatcher next) _streamDocsKanbanBoardAction() {
  return (store, action, next) {
    print('_streamDocsKanbanBoardAction');
    Firestore firestore = Firestore.instance;
    Stream<QuerySnapshot> streamDocs;
    if (store.state.kanbanBoardState.kanbanBoardFilter ==
        KanbanBoardFilter.active) {
      streamDocs = firestore
          .collection(KanbanBoardModel.collection)
          // .where('active', isEqualTo: true)
          // .where('author.id', isEqualTo: store.state.userState.firebaseUser.uid)
          .snapshots();
    } else if (store.state.kanbanBoardState.kanbanBoardFilter ==
        KanbanBoardFilter.inactive) {
      streamDocs = firestore
          .collection(KanbanBoardModel.collection)
          // .where('active', isEqualTo: false)
          // .where('author.id', isEqualTo: store.state.userState.firebaseUser.uid)
          .snapshots();
    } else if (store.state.kanbanBoardState.kanbanBoardFilter ==
        KanbanBoardFilter.publics) {
      streamDocs = firestore
          .collection(KanbanBoardModel.collection)
          // .where('active', isEqualTo: false)
          // .where('public', isEqualTo: false)
          .snapshots();
    }
    final listDocs = streamDocs.map((snapDocs) => snapDocs.documents
        .map((doc) => KanbanBoardModel(doc.documentID).fromFirestore(doc.data))
        .toList());
    listDocs.listen((List<KanbanBoardModel> allKanbanBoardModel) {
      print('allKanbanBoardModel: ${allKanbanBoardModel.length}');
      store.dispatch(
          AllKanbanBoardModelAction(allKanbanBoardModel: allKanbanBoardModel));
    });
    next(action);
  };
}

void Function(Store<AppState> store, UpdateKanbanBoardAction action,
    NextDispatcher next) _updateDocKanbanBoardAction() {
  return (store, action, next) {
        print('_updateDocKanbanBoardAction');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanBoardModel.collection)
        .document(action.kanbanBoardModel.id)
        .updateData(action.kanbanBoardModel.toFirestore());
    next(action);
  };
}

void Function(Store<AppState> store, DeleteKanbanBoardAction action,
    NextDispatcher next) _deleteDocKanbanBoardAction() {
  return (store, action, next) {
        print('_deleteDocKanbanBoardAction');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanBoardModel.collection)
        .document(action.id)
        .delete();
    next(action);
  };
}

void Function(
        Store<AppState> store, AddKanbanBoardAction action, NextDispatcher next)
    _addDocKanbanBoardAction() {
  return (store, action, next) {
        print('_addDocKanbanBoardAction');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanBoardModel.collection)
        .document()
        .setData(action.kanbanBoardModel.toFirestore());
    next(action);
  };
}
