import 'package:meta/meta.dart';
import 'package:pmsb4/models/collection_model.dart';
import 'package:pmsb4/states/type_states.dart';

@immutable
class CollectionState {
  final CollectionModel currentCollectionModel;
  final List<CollectionModel> allCollectionModel;
  final List<CollectionModel> filteredCollectionModel;
  final CollectionFilter collectionFilter;
  CollectionState({
    this.allCollectionModel,
    this.currentCollectionModel,
    this.collectionFilter,
    this.filteredCollectionModel,
  });

  factory CollectionState.initial() {
    return CollectionState(
      currentCollectionModel: null,
      allCollectionModel: [],
      filteredCollectionModel: [],
      collectionFilter: CollectionFilter.all,
    );
  }
  CollectionState copyWith({
    CollectionModel collectionModel,
    List<CollectionModel> allCollectionModel,
    List<CollectionModel> filteredCollectionModel,
    CollectionFilter collectionFilter,
  }) {
    return CollectionState(
      currentCollectionModel: collectionModel ?? this.currentCollectionModel,
      allCollectionModel: allCollectionModel ?? this.allCollectionModel,
      collectionFilter: collectionFilter ?? this.collectionFilter,
      filteredCollectionModel:
          filteredCollectionModel ?? this.filteredCollectionModel,
    );
  }

  @override
  int get hashCode =>
      currentCollectionModel.hashCode ^
      allCollectionModel.hashCode ^
      collectionFilter.hashCode ^
      filteredCollectionModel.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionState &&
          runtimeType == other.runtimeType &&
          currentCollectionModel == other.currentCollectionModel &&
          allCollectionModel == other.allCollectionModel &&
          collectionFilter == other.collectionFilter &&
          filteredCollectionModel == other.filteredCollectionModel;

  @override
  String toString() {
    return 'CollectionState{collectionModel:$currentCollectionModel,allCollectionModel:$allCollectionModel,collectionFilter:$collectionFilter,filteredCollectionModel:$filteredCollectionModel}';
  }
}
