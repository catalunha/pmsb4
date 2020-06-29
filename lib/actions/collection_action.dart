import 'package:pmsb4/models/collection_model.dart';
import 'package:pmsb4/states/type_states.dart';

class CollectionAction {}

// +++ Actions atendidas pelo CollectionReducer
class AllCollectionModelAction extends CollectionAction {
  final List<CollectionModel> allCollectionModel;

  AllCollectionModelAction({this.allCollectionModel});
}

class CurrentCollectionModelAction extends CollectionAction {
  final int index;
  CurrentCollectionModelAction({this.index});
}

class UpdateCollectionFilterAction extends CollectionAction {
  final CollectionFilter collectionFilter;

  UpdateCollectionFilterAction({this.collectionFilter});
}

class FilteredCollectionModelAction extends CollectionAction {}

// +++ Actions atendidas pelo firebaseFirestoreCollectionMiddleware
class AddCollectionAction extends CollectionAction {
  final CollectionModel collectionModel;

  AddCollectionAction({this.collectionModel});
}

class StreamCollectionAction extends CollectionAction {}

class UpdateCollectionAction extends CollectionAction {
  final CollectionModel collectionModel;
  UpdateCollectionAction({this.collectionModel});
}

class DeleteCollectionAction extends CollectionAction {
  final String id;

  DeleteCollectionAction({this.id});
}
