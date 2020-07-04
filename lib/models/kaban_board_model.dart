import 'package:pmsb4/models/firestore_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:sortedmap/sortedmap.dart';

class KanbanBoardModel extends FirestoreModel {
  static final String collection = 'kanbanBoard';

  String title;
  String description;
  bool public;
  Team author;
  Map<String, Team> team = Map<String, Team>();
  Map<String, String> cardOrder = Map<String, String>();

  dynamic created;
  dynamic modified;
  bool active;

  KanbanBoardModel(
    String id, {
    this.title,
    this.description,
    this.public,
    this.author,
    this.team,
    this.cardOrder,
    this.created,
    this.modified,
    this.active,
  }) : super(id);

  @override
  @override
  KanbanBoardModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('title')) title = map['title'];
    if (map.containsKey('description')) description = map['description'];
    if (map.containsKey('public')) public = map['public'];
    author = map.containsKey('author') && map['author'] != null
        ? Team.fromMap(map['author'])
        : null;
    if (map["team"] is Map && map["team"] != null) {
      team = Map<String, Team>();
      for (var item in map["team"].entries) {
        team[item.key] = Team.fromMap(item.value);
      }
    }
    if (map["cardOrder"] is Map && map["cardOrder"] != null) {
      cardOrder = new SortedMap(Ordering.byKey());
      for (var item in map["cardOrder"].entries) {
        cardOrder[item.key] = item.value;
      }
    }
    created = map.containsKey('created') && map['created'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            map['created'].millisecondsSinceEpoch)
        : null;
    modified = map.containsKey('modified') && map['modified'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            map['modified'].millisecondsSinceEpoch)
        : null;
    if (map.containsKey('active')) active = map['active'];

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (title != null) data['title'] = this.title;
    if (description != null) data['description'] = this.description;
    if (public != null) data['public'] = this.public;
    if (this.author != null) {
      data['author'] = this.author.toMap();
    }
    if (team != null && team is Map) {
      data["team"] = Map<String, dynamic>();
      for (var item in team.entries) {
        data["team"][item.key] = item.value.toMap();
      }
    }
    if (cardOrder != null && cardOrder is Map) {
      data["cardOrder"] = Map<String, dynamic>();
      for (var item in cardOrder.entries) {
        data["cardOrder"][item.key] = item.value;
      }
    }
    if (created != null) data['created'] = this.created;
    if (modified != null) data['modified'] = this.modified;
    if (active != null) data['active'] = this.active;

    return data;
  }

  KanbanBoardModel fromFirestore(Map<String, dynamic> map) {
    return this.fromMap(map);
  }

  @override
  Map<String, dynamic> toFirestore() {
    this.modified = DateTime.now();
    return this.toMap();
  }

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
      public.hashCode ^
      author.hashCode ^
      team.hashCode ^
      cardOrder.hashCode ^
      created.hashCode ^
      modified.hashCode ^
      active.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KanbanBoardModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          public == other.public &&
          author == other.author &&
          team == other.team &&
          cardOrder == other.cardOrder &&
          created == other.created &&
          modified == other.modified &&
          active == other.active;
}
