import 'package:pmsb4/actions/colecao_action.dart';
import 'package:pmsb4/states/colecao_state.dart';
import 'package:redux/redux.dart';

final colecaoReducer = combineReducers<ColecaoState>([
  TypedReducer<ColecaoState, ColecaoListDocsAction>(_colecaoListDocsAction),
  TypedReducer<ColecaoState, ColecaoCurrentDocAction>(_colecaoCurrentDocAction),
]);

ColecaoState _colecaoListDocsAction(
    ColecaoState state, ColecaoListDocsAction action) {
  return state.copyWith(listColecaoModel: action.listColecaoModel);
}

ColecaoState _colecaoCurrentDocAction(
    ColecaoState state, ColecaoCurrentDocAction action) {
  print('_colecaoCurrentDocAction:${state.listColecaoModel}');
  return state.copyWith(colecaoModel: state.listColecaoModel[action.index]);
}
