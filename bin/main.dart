class CollectionModel {
  final int valor;
  final bool check;
  CollectionModel({
    this.valor,
    this.check,
  });
}

void main() {
  List<CollectionModel> allCollectionModel = [];
  allCollectionModel.add(CollectionModel(valor: 1, check: true));
  allCollectionModel.add(CollectionModel(valor: 2, check: false));
  allCollectionModel.add(CollectionModel(valor: 3, check: true));
  print(allCollectionModel);
  List<CollectionModel> filteredCollectionModel;
  // collectionModelSelected.add(allCollectionModel[1]);
  // print(collectionModelSelected);
  // print(allCollectionModel.contains(collectionModelSelected[0]));
  filteredCollectionModel =
      allCollectionModel.where((element) => element.check == true).toList();
  filteredCollectionModel.forEach((element) {
    print(element.valor);
  });
}
