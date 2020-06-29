import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/models/user_model.dart';

import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/type_states.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseFirestoreUserMiddleware() {
  return [
    TypedMiddleware<AppState, StreamUserDataAction>(_streamDocsUsersAction()),
    // TypedMiddleware<AppState, UpdateUsersAction>(
    //     _UsersUpdateDocAction()),
    // TypedMiddleware<AppState, DeleteUsersAction>(
    //     _UsersDeleteDocsAction()),
    // TypedMiddleware<AppState, AddUsersAction>(
    //     _UsersAddDocAction()),
  ];
}

void Function(
  Store<AppState> store,
  StreamUserDataAction action,
  NextDispatcher next,
) _streamDocsUsersAction() {
  return (store, action, next) async {
    print('_streamDocsUsersAction...');
    Firestore firestore = Firestore.instance;
    //Pode aplicar filtro na stream
    final streamDocs = firestore.collection(UserModel.collection).snapshots();
    final listDocs = streamDocs.map((snapDocs) => snapDocs.documents
        .map((doc) => UserModel(doc.documentID).fromFirestore(doc.data))
        .toList());
    // await fetchUserOrder();
    listDocs.listen((List<UserModel> allUserModel) {
      store.dispatch(AllUserModelAction(allUserModel: allUserModel));
      //Ou pode aplicar filtro após all
      store.dispatch(UpdateUserFilterAction(usersFilter: UserFilter.all));
    });
    next(action);
  };
}

// void Function(
//   Store<AppState> store,
//   UpdateUsersAction action,
//   NextDispatcher next,
// ) _UsersUpdateDocAction() {
//   return (store, action, next) {
//     print('_UsersUpdateDocAction');
//     Firestore firestore = Firestore.instance;
//     firestore
//         .Users(UsersModel.Users)
//         .document(action.UsersModel.id)
//         .updateData(action.UsersModel.toFirestore());
//     next(action);
//   };
// }

// void Function(
//   Store<AppState> store,
//   DeleteUsersAction action,
//   NextDispatcher next,
// ) _UsersDeleteDocsAction() {
//   return (store, action, next) {
//     print('_UsersDeleteDocsAction');
//     Firestore firestore = Firestore.instance;
//     firestore
//         .Users(UsersModel.Users)
//         .document(action.id)
//         .delete();
//     next(action);
//   };
// }
// void Function(
//   Store<AppState> store,
//   AddUsersAction action,
//   NextDispatcher next,
// ) _UsersAddDocAction(){
//   return (store, action, next) {
//     print('_UsersAddDocAction');
//     Firestore firestore = Firestore.instance;
//     firestore
//         .Users(UsersModel.Users)
//         .document()
//         .setData(action.UsersModel.toFirestore());
//     next(action);
//   };
// }
