import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/types_states.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseFirestoreKanbanCardMiddleware() {
  return [
    TypedMiddleware<AppState, StreamKanbanCardDataAction>(
        _streamKanbanCardAction()),
    TypedMiddleware<AppState, UpdateKanbanCardDataAction>(
        _updateKanbanCardAction()),
    TypedMiddleware<AppState, DeleteKanbanCardDataAction>(
        _deleteKanbanCardAction()),
    TypedMiddleware<AppState, AddKanbanCardDataAction>(_addKanbanCardAction()),
    // TypedMiddleware<AppState, UpdateFieldKanbanCardAction>(
    //     _updateFieldKanbanCardAction()),
  ];
}

void Function(Store<AppState> store, StreamKanbanCardDataAction action,
    NextDispatcher next) _streamKanbanCardAction() {
  return (store, action, next) {
    print('_streamKanbanCardAction...');
    Firestore firestore = Firestore.instance;
    Stream<QuerySnapshot> streamDocs;
    KanbanCardFilter currentFilter =
        store.state.kanbanCardState.kanbanCardFilter;
    if (currentFilter == KanbanCardFilter.all) {
      streamDocs = firestore
          .collection(KanbanCardModel.collection)
          .where('active', isEqualTo: true)
          .where('kanbanBoard',
              isEqualTo:
                  store.state.kanbanBoardState.currentKanbanBoardModel.id)
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
      store.dispatch(AllKanbanCardModelAction(
          allKanbanCardModel: allKanbanCardModel,
          currentKanbanBoardModel:
              store.state.kanbanBoardState.currentKanbanBoardModel));
      // store.dispatch(
      //     UpdateKanbanCardFilterAction(kanbanCardFilter: currentFilter));
      // store.dispatch(CurrentKanbanCardModelAction(
      //     id: store.state.kanbanCardState.currentKanbanCardModel?.id));
    });
    next(action);
  };
}

void Function(Store<AppState> store, UpdateKanbanCardDataAction action,
    NextDispatcher next) _updateKanbanCardAction() {
  return (store, action, next) async {
    print('_updateKanbanCardAction...');
    // print(action.kanbanCardModel.toFirestore());
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanCardModel.collection)
        .document(action.kanbanCardModel.id)
        .updateData(action.kanbanCardModel.toFirestore());
    // .setData(action.kanbanCardModel.toFirestore(), merge: true);
    //       await Future.delayed(
    //   Duration(seconds: 5),
    //   () => 'Large Latte',
    // );
    // print('só um');
    //         firestore
    //     .collection(KanbanCardModel.collection)
    //     .document(action.kanbanCardModel.id)
    //     .setData({'todo':{'1':{'complete':true}}}, merge: true);
    next(action);
  };
}

// void Function(Store<AppState> store, UpdateFieldKanbanCardAction action,
//     NextDispatcher next) _updateFieldKanbanCardAction() {
//   return (store, action, next) {
//     print('_updateKanbanCardAction...');
//     Firestore firestore = Firestore.instance;
//     firestore
//         .collection(KanbanCardModel.collection)
//         .document(store.state.kanbanCardState.currentKanbanCardModel.id)
//         .setData(action.map, merge: true);
//     next(action);
//   };
// }

void Function(Store<AppState> store, DeleteKanbanCardDataAction action,
    NextDispatcher next) _deleteKanbanCardAction() {
  return (store, action, next) {
    print('_deleteKanbanCardAction...');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanCardModel.collection)
        .document(action.id)
        .delete();
    next(action);
  };
}

void Function(Store<AppState> store, AddKanbanCardDataAction action,
    NextDispatcher next) _addKanbanCardAction() {
  return (store, action, next) {
    print('_addKanbanCardAction...');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanCardModel.collection)
        .document()
        .setData(action.kanbanCardModel.toFirestore());
    next(action);
  };
}
