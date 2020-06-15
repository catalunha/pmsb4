
import 'package:pmsb4/middlewares/firebase/firestore/firestore_model.dart';

class UserModel extends FirestoreModel {
  static final String collection = 'Usuario';
  String nickname;

  UserModel(
    String id, {
    this.nickname,
  }) : super(id);
  @override
  UserModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('nickname')) nickname = map['nickname'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (nickname != null) data['nickname'] = this.nickname;
    return data;
  }
  @override
  UserModel fromFirestore(Map<String, dynamic> map) {
    if (map.containsKey('nome')) nickname = map['nome'];
    return this;
  }

  @override
  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (nickname != null) data['nome'] = this.nickname;
    return data;
  }
  @override
  String toString(){
    return this.toMap().toString();
  }
}
