import 'package:pmsb4/models/firestore_model.dart';
import 'package:pmsb4/models/type_models.dart';

class KanbanBoardModel extends FirestoreModel {
  static final String collection = 'kanbanBoard';

  String title;
  String description;
  bool public;
  Team author;
  Map<String, Team> team = Map<String, Team>();
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
    if (map["team"] is Map) {
      team = Map<String, Team>();
      for (var item in map["team"].entries) {
        team[item.key] = Team.fromMap(item.value);
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
    if (description != null && description.isNotEmpty)
      data['description'] = this.description;
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
}
