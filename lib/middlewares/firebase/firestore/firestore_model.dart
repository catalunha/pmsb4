abstract class FirestoreModel {
  static final String collection = null;
  String id;
  FirestoreModel(this.id);
  Map<String, dynamic> toMap();
  FirestoreModel fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toFirestore();
  FirestoreModel fromFirestore(Map<String, dynamic> map);
  @override
  String toString() {
    return toMap().toString();
  }
}
