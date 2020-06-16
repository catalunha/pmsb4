import 'package:pmsb4/middlewares/firebase/firestore/colecao/colecao_model.dart';

class ColecaoAction {}

// +++ Actions atendidas pelo ColecaoReducer
class ColecaoListDocsAction extends ColecaoAction {
  final List<ColecaoModel> listColecaoModel;

  ColecaoListDocsAction({this.listColecaoModel});
}
class ColecaoCurrentDocAction extends ColecaoAction{
  final int index;

  ColecaoCurrentDocAction({this.index});
}

// +++ Actions atendidas pelo firebaseFirestoreColecaoMiddleware
class ColecaoStreamDocsAction extends ColecaoAction {}

class ColecaoAddDocAction extends ColecaoAction {
  final ColecaoModel colecaoModel;

  ColecaoAddDocAction({this.colecaoModel});
}

class ColecaoDeleteDocsAction extends ColecaoAction {
  final List<ColecaoModel> listColecaoModel;

  ColecaoDeleteDocsAction({this.listColecaoModel});
}

class ColecaoUpdateDocAction extends ColecaoAction {
  final ColecaoModel colecaoModel;

  ColecaoUpdateDocAction({this.colecaoModel});
}
