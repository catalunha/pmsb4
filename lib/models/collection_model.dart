import 'package:pmsb4/models/firestore_model.dart';
class CollectionModel extends FirestoreModel {
  static final String collection = 'colecao';
  String letter;
  bool check;

  CollectionModel(
    String id, {
    this.letter,
    this.check,
  }) : super(id);

  @override
  CollectionModel fromFirestore(Map<String, dynamic> map) {
    if (map.containsKey('letra')) letter = map['letra'];
    if (map.containsKey('marcado')) check = map['marcado'];
    return this;
  }

  @override
  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (letter != null) data['letra'] = this.letter;
    if (check != null) data['marcado'] = this.check;
    return data;
  }

  @override
  CollectionModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('letter')) letter = map['letter'];
    if (map.containsKey('check')) check = map['check'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (letter != null) data['letter'] = this.letter;
    if (check != null) data['check'] = this.check;
    return data;
  }
}
