// enumerations types

enum StageCard {
  story,
  todo,
  doing,
  check,
  done,
}

//class types

class Team {
  String id;
  String displayName;
  String photoUrl;
  bool readedCard;

  Team({
    this.id,
    this.displayName,
    this.photoUrl,
    this.readedCard,
  });
  Team.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('id')) id = map['id'];
    if (map.containsKey('displayName')) displayName = map['displayName'];
    if (map.containsKey('photoUrl')) photoUrl = map['photoUrl'];
    if (map.containsKey('readedCard')) readedCard = map['readedCard'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (displayName != null) data['displayName'] = this.displayName;
    if (photoUrl != null) data['photoUrl'] = this.photoUrl;
    if (readedCard != null) data['readedCard'] = this.readedCard;
    return data;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      displayName.hashCode ^
      photoUrl.hashCode ^
      readedCard.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Team &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          displayName == other.displayName &&
          photoUrl == other.photoUrl &&
          readedCard == other.readedCard;
}
