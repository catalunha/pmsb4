import 'package:pmsb4/models/collection_model.dart';
import 'package:pmsb4/states/collection_state.dart';

CollectionModel collectionCurrentSelectedSelector(
        CollectionState state, int index) =>
    state.allCollectionModel[index];
