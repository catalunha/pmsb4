import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/states/collection_state.dart';
import 'package:redux/redux.dart';

final collectionReducer = combineReducers<CollectionState>([
  TypedReducer<CollectionState, CollectionListDocsAction>(_collectionListDocsAction),
  TypedReducer<CollectionState, CollectionCurrentDocAction>(_collectionCurrentDocAction),
]);

CollectionState _collectionListDocsAction(
    CollectionState state, CollectionListDocsAction action) {
  return state.copyWith(listCollectionModel: action.listCollectionModel);
}

CollectionState _collectionCurrentDocAction(
    CollectionState state, CollectionCurrentDocAction action) {
  print('_collectionCurrentDocAction:${state.listCollectionModel}');
  return state.copyWith(collectionModel: state.listCollectionModel[action.index]);
}
