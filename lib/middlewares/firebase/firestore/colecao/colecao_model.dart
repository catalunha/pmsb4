import 'package:pmsb4/middlewares/firebase/firestore/firestore_model.dart';

class ColecaoModel extends FirestoreModel {
  static final String collection = 'colecao';
  String letter;

  ColecaoModel(
    String id, {
    this.letter,
  }) : super(id);

  @override
  ColecaoModel fromFirestore(Map<String, dynamic> map) {
    if (map.containsKey('letra')) letter = map['letra'];
    return this;
  }

  @override
  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (letter != null) data['letra'] = this.letter;
    return data;
  }

  @override
  ColecaoModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('letter')) letter = map['letter'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (letter != null) data['letter'] = this.letter;
    return data;
  }
}
