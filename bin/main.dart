void main() {
  Map<String, String> map = Map<String, String>();
  // map['1'] = '2';
  // map = {'4': '2', '1': '3', '2': '6', '3': '1'};
  print(map.length);
}
/*
main() {

  List myList = [
    {'id': 'red', 'test': 'some data'},
    {'id': 'green', 'other': 'some other data'},
    {'id': 'blue'},
  ];

  List myOrderList = ['green', 'red', 'blue'];

  List orderByOtherList(List theList, String commonField, List orderList) {
    List listOut = [];
    orderList.forEach((o) => listOut.add(theList.firstWhere((m) => m[commonField] == o)));
    return listOut;
  }

  print(myList);
  print(orderByOtherList(myList, 'id', myOrderList));
}
ou
main() {

	List myList = [
    {'id': 'red', 'test': 'some data'},
    {'id': 'green', 'other': 'some other data'},
    {'id': 'blue'},
  ];
  
  List myOrderList = [
    {'id': 'red', 'order': 1},
    {'id': 'green', 'order': 0},
    {'id': 'blue', 'order': 2},
  ];
  
  List orderByOtherList(List theList, String commonField, List orderList, String orderfield) {
    List listOut = [];
    orderList.sort((a, b) => a[orderfield].compareTo(b[orderfield]));
    orderList.forEach((o) => listOut.add(theList.firstWhere((m) => m[commonField] == o[commonField])));
    return listOut;
  }
  
  print(myList);
  print(orderByOtherList(myList, 'id', myOrderList, 'order'));
}
*/

class Todo {
  String id;
  String title;
  bool complete;

  Todo({
    this.id,
    this.title,
    this.complete,
  });
  Todo.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('title')) title = map['title'];
    if (map.containsKey('complete')) complete = map['complete'];
    if (map.containsKey('id')) id = map['id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (title != null) data['title'] = this.title;
    if (complete != null) data['complete'] = this.complete;
    if (id != null) data['id'] = this.id;
    return data;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ complete.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          id == other.id &&
          title == other.title &&
          complete == other.complete;
}

void teste2() {
  List<CollectionModel> allCollectionModel = [];
  allCollectionModel.add(CollectionModel(valor: 1, check: true));
  allCollectionModel.add(CollectionModel(valor: 2, check: false));
  allCollectionModel.add(CollectionModel(valor: 3, check: true));
  CollectionModel a =
      allCollectionModel.firstWhere((element) => element.valor == 3);
  print(a);
}

class CollectionModel {
  final int valor;
  final bool check;
  CollectionModel({
    this.valor,
    this.check,
  });
  @override
  String toString() {
    return 'CollectionModel{valor:$valor,check:$check}';
  }
}

void testeLista() {
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
