import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmsb4/actions/colecao_action.dart';
import 'package:pmsb4/middlewares/firebase/firestore/colecao/colecao_model.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseFirestoreColecaoMiddleware() {
  return [
    TypedMiddleware<AppState, ColecaoStreamDocsAction>(
        _colecaoStreamDocsAction()),
  ];
}

Middleware<AppState> _colecaoStreamDocsAction() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    print('_colecaoStreamDocsAction');
    Firestore firestore = Firestore.instance;
    final streamDocs =
        firestore.collection(ColecaoModel.collection).snapshots();
    final listDocs = streamDocs.map((snapDocs) => snapDocs.documents
        .map((doc) => ColecaoModel(doc.documentID).fromFirestore(doc.data))
        .toList());
    listDocs.listen((List<ColecaoModel> listColecaoModel) {
      print('listColecaoModel: ${listColecaoModel.length}');
      store.dispatch(ColecaoListDocsAction(listColecaoModel: listColecaoModel));
    });
    next(action);
  };
}
