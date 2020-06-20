import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/models/collection_model.dart';
import 'package:pmsb4/states/collection_state.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:redux/redux.dart';

final collectionReducer = combineReducers<CollectionState>([
  TypedReducer<CollectionState, AllCollectionModelAction>(
      _allCollectionModelAction),
  TypedReducer<CollectionState, CurrentCollectionModelAction>(
      _currentCollectionModelAction),
  TypedReducer<CollectionState, UpdateCollectionFilterAction>(
      _updateCollectionFilterAction),
  TypedReducer<CollectionState, FilteredCollectionModelAction>(
      _filteredCollectionModelAction),
]);

CollectionState _allCollectionModelAction(
    CollectionState state, AllCollectionModelAction action) {
  CollectionState _state;

  return state.copyWith(allCollectionModel: action.allCollectionModel);
}

CollectionState _currentCollectionModelAction(
    CollectionState state, CurrentCollectionModelAction action) {
  // print('_currentCollectionModelAction:${state.allCollectionModel}');
  return state.copyWith(
      collectionModel: state.allCollectionModel[action.index]);
}

CollectionState _updateCollectionFilterAction(
    CollectionState state, UpdateCollectionFilterAction action) {
      print(action.collectionFilter);
  CollectionState _state =
      state.copyWith(collectionFilter: action.collectionFilter);
  // collectionReducer(_state, FilteredCollectionModelAction());
  return collectionReducer(_state, FilteredCollectionModelAction());;
}

CollectionState _filteredCollectionModelAction(
    CollectionState state, FilteredCollectionModelAction action) {
  List<CollectionModel> filteredCollectionModel = [];
print('_filteredCollectionModelAction');
  if (state.collectionFilter == CollectionFilter.all) {
    filteredCollectionModel = state.allCollectionModel;
  } else if (state.collectionFilter == CollectionFilter.checkTrue) {
    filteredCollectionModel = state.allCollectionModel
        .where((element) => element.check == true)
        .toList();
  } else if (state.collectionFilter == CollectionFilter.checkFalse) {
    filteredCollectionModel = state.allCollectionModel
        .where((element) => element.check == false)
        .toList();
  } else if (state.collectionFilter == CollectionFilter.checkNull) {
    filteredCollectionModel = state.allCollectionModel
        .where((element) => element.check == null)
        .toList();
  }
  return state.copyWith(filteredCollectionModel: filteredCollectionModel);
}
