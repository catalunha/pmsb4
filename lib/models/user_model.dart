
import 'package:pmsb4/models/firestore_model.dart';

class UserModel extends FirestoreModel {
  static final String collection = 'Usuario';
  String displayName;
  String photoUrl;

  UserModel(
    String id, {
    this.displayName,
    this.photoUrl
  }) : super(id);
  @override
  UserModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('displayName')) displayName = map['displayName'];
    if (map.containsKey('photoUrl')) photoUrl = map['photoUrl'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (displayName != null) data['displayName'] = this.displayName;
    if (photoUrl != null) data['photoUrl'] = this.photoUrl;
    return data;
  }
  @override
  UserModel fromFirestore(Map<String, dynamic> map) {
    if (map.containsKey('nome')) displayName = map['nome'];
    if (map.containsKey('foto')) {
      photoUrl = map['foto'] != null ? new UploadFk.fromMap(map['foto']).url : null;
    }    return this;
  }

  @override
  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (displayName != null) data['nome'] = this.displayName;
    if (photoUrl != null) data['foto.url'] = this.photoUrl;
    return data;
  }
  @override
  String toString(){
    return this.toMap().toString();
  }
}
class UploadFk {
  String uploadID;
  String url;
  String path;

  UploadFk({
    this.uploadID,
    this.url,
    this.path,
  });

  UploadFk.fromMap(Map<dynamic, dynamic> map) {
    if (map.containsKey('uploadID')) uploadID = map['uploadID'];
    if (map.containsKey('url')) url = map['url'];
    if (map.containsKey('path')) path = map['path'];
  }

  // Map<dynamic, dynamic> toMap() {
  //   final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
  //   if (uploadID != null) data['uploadID'] = this.uploadID;
  //   data['url'] = this.url ?? Bootstrap.instance.fieldValue.delete();
  //   data['path'] = this.path ?? Bootstrap.instance.fieldValue.delete();
  //   return data;
  // }
}