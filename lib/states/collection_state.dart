import 'package:meta/meta.dart';
import 'package:pmsb4/model/collection/collection_model.dart';

@immutable
class CollectionState {
  final CollectionModel collectionModel;
  final List<CollectionModel> listCollectionModel;
  CollectionState({
    this.listCollectionModel,
    this.collectionModel,
  });

  factory CollectionState.initial() {
    return CollectionState(
      collectionModel: null,
      listCollectionModel: [],
    );
  }
  CollectionState copyWith({
    CollectionModel collectionModel,
    List<CollectionModel> listCollectionModel,
  }) {
    return CollectionState(
      collectionModel: collectionModel ?? this.collectionModel,
      listCollectionModel: listCollectionModel ?? this.listCollectionModel,
    );
  }

  @override
  int get hashCode => collectionModel.hashCode ^ listCollectionModel.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionState &&
          runtimeType == other.runtimeType &&
          collectionModel == other.collectionModel &&
          listCollectionModel == other.listCollectionModel;

  @override
  String toString() {
    return 'CollectionState{collectionModel:$collectionModel,listCollectionModel:$listCollectionModel}';
  }
}
