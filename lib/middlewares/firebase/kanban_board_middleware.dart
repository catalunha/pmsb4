import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/types_states.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseFirestoreKanbanBoardMiddleware() {
  return [
    TypedMiddleware<AppState, StreamKanbanBoardDataAction>(
        _streamDocsKanbanBoardAction()),
    TypedMiddleware<AppState, UpdateKanbanBoardDataAction>(
        _updateDocKanbanBoardAction()),
    TypedMiddleware<AppState, DeleteKanbanBoardDataAction>(
        _deleteDocKanbanBoardAction()),
    TypedMiddleware<AppState, AddKanbanBoardDataAction>(
        _addDocKanbanBoardAction()),
    // TypedMiddleware<AppState, AddUserToTeamKanbanBoardAction>(
    //     _addUserToTeamKanbanBoardAction()),
  ];
}

void Function(Store<AppState> store, StreamKanbanBoardDataAction action,
    NextDispatcher next) _streamDocsKanbanBoardAction() {
  return (store, action, next) {
    //print('_streamDocsKanbanBoardAction...');
    Firestore firestore = Firestore.instance;
    Stream<QuerySnapshot> streamDocs;
    KanbanBoardFilter currentFilter =
        store.state.kanbanBoardState.kanbanBoardFilter;
    if (currentFilter == KanbanBoardFilter.all) {
      streamDocs = firestore
          .collection(KanbanBoardModel.collection)
          // .where('active', isEqualTo: true)
          // .where('author.id', isEqualTo: store.state.loggedState.firebaseUserLogged.uid)
          .snapshots();
    } else if (currentFilter == KanbanBoardFilter.activeAuthor) {
      streamDocs = firestore
          .collection(KanbanBoardModel.collection)
          .where('active', isEqualTo: true)
          .where('author.id',
              isEqualTo: store.state.loggedState.firebaseUserLogged.uid)
          .snapshots();
    } else if (currentFilter == KanbanBoardFilter.activeTeam) {
      streamDocs = firestore
          .collection(KanbanBoardModel.collection)
          .where('active', isEqualTo: true)
          .where('team.${store.state.loggedState.firebaseUserLogged.uid}.id',
              isEqualTo: store.state.loggedState.firebaseUserLogged.uid)
          .snapshots();
    } else if (currentFilter == KanbanBoardFilter.inactive) {
      streamDocs = firestore
          .collection(KanbanBoardModel.collection)
          .where('active', isEqualTo: false)
          .where('author.id',
              isEqualTo: store.state.loggedState.firebaseUserLogged.uid)
          .snapshots();
    } else if (currentFilter == KanbanBoardFilter.publics) {
      streamDocs = firestore
          .collection(KanbanBoardModel.collection)
          .where('active', isEqualTo: true)
          .where('public', isEqualTo: true)
          .snapshots();
    }
    final listDocs = streamDocs.map((snapDocs) => snapDocs.documents
        .map((doc) => KanbanBoardModel(doc.documentID).fromFirestore(doc.data))
        .toList());
    listDocs.listen((List<KanbanBoardModel> allKanbanBoardModel) {
      //print('currentKanbanBoardFilter: ${currentFilter}');
      //print('allKanbanBoardModel: ${allKanbanBoardModel.length}');
      store.dispatch(
          AllKanbanBoardModelAction(allKanbanBoardModel: allKanbanBoardModel));
      // store.dispatch(AllKanbanCardModelAction(
      //     allKanbanCardModel: null,
      //     currentKanbanBoardModel:
      //         store.state.kanbanBoardState.currentKanbanBoardModel));
    });
    next(action);
  };
}

void Function(Store<AppState> store, UpdateKanbanBoardDataAction action,
    NextDispatcher next) _updateDocKanbanBoardAction() {
  return (store, action, next) {
    //print('_updateDocKanbanBoardAction...');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanBoardModel.collection)
        .document(action.kanbanBoardModel.id)
        .updateData(action.kanbanBoardModel.toFirestore());
    next(action);
  };
}

void Function(Store<AppState> store, DeleteKanbanBoardDataAction action,
    NextDispatcher next) _deleteDocKanbanBoardAction() {
  return (store, action, next) {
    //print('_deleteDocKanbanBoardAction...');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanBoardModel.collection)
        .document(action.id)
        .delete();
    next(action);
  };
}

void Function(Store<AppState> store, AddKanbanBoardDataAction action,
    NextDispatcher next) _addDocKanbanBoardAction() {
  return (store, action, next) {
    //print('_addDocKanbanBoardAction...');
    Firestore firestore = Firestore.instance;
    firestore
        .collection(KanbanBoardModel.collection)
        .document()
        .setData(action.kanbanBoardModel.toFirestore());
    next(action);
  };
}

// void Function(Store<AppState> store, AddUserToTeamKanbanBoardAction action,
//     NextDispatcher next) _addUserToTeamKanbanBoardAction() {
//   return (store, action, next) {
//     //print('_addUserToTeamKanbanBoardAction');
//     Firestore firestore = Firestore.instance;
//     KanbanBoardModel currentKanbanBoardModel =
//         store.state.kanbanBoardState.currentKanbanBoardModel;
//     if (currentKanbanBoardModel?.team == null ||
//         !currentKanbanBoardModel.team.containsKey(action.id)) {
//       UserModel userModel = store.state.usersState.allUserModel
//           .firstWhere((element) => element.id == action.id);
//       UserKabanRef team = UserKabanRef(
//         id: userModel.id,
//         displayName: userModel.displayName,
//         photoUrl: userModel.photoUrl,
//       );
//       //print('currentKanbanBoardModel:${currentKanbanBoardModel.id}');
//       currentKanbanBoardModel.fromMap({'team':'{${userModel.id}: $team}'});
//       firestore
//           .collection(KanbanBoardModel.collection)
//           .document(currentKanbanBoardModel.id)
//           .updateData(currentKanbanBoardModel.toFirestore());
//     }

//     next(action);
//   };
// }
