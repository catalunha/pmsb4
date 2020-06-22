import 'package:pmsb4/models/enums_models.dart';
import 'package:pmsb4/models/firestore_model.dart';
import 'package:pmsb4/models/references_models.dart';

class KanbanCardModel extends FirestoreModel {
  static final String collection = 'kanbanCard';
  String kanbanBoard;
  String title;
  String description;
  bool priority;
  UserKabanRef author;
  StageCard stageCard;
  Map<String, UserKabanRef> team = Map<String, UserKabanRef>();
  Map<String, Todo> todo = Map<String, Todo>();
  Map<String, Feed> feed = Map<String, Feed>();
  dynamic created;
  dynamic modified;
  bool active;
  int todoOrder;
  //update in intance.
  int todoCompleted;
  int todoTotal;
  KanbanCardModel(
    String id, {
    this.kanbanBoard,
    this.title,
    this.description,
    this.priority,
    this.author,
    this.team,
    this.created,
    this.modified,
    this.active,
  }) : super(id);

  @override
  @override
  FirestoreModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('kanbanBoard')) kanbanBoard = map['kanbanBoard'];
    if (map.containsKey('title')) title = map['title'];
    if (map.containsKey('description')) description = map['description'];
    if (map.containsKey('priority')) priority = map['priority'];
    author = map.containsKey('author') && map['author'] != null
        ? UserKabanRef.fromMap(map['author'])
        : null;
    if (map["team"] is Map) {
      team = Map<String, UserKabanRef>();
      for (var item in map["team"].entries) {
        team[item.key] = UserKabanRef.fromMap(item.value);
      }
    }
    if (map["todo"] is Map) {
      todo = Map<String, Todo>();
      for (var item in map["todo"].entries) {
        todo[item.key] = Todo.fromMap(item.value);
      }
      updateTodo();
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

  void updateTodo() {
    print('updateTodo');
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (kanbanBoard != null) data['kanbanBoard'] = this.kanbanBoard;
    if (title != null) data['title'] = this.title;
    if (description != null) data['description'] = this.description;
    if (priority != null) data['priority'] = this.priority;
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

  FirestoreModel fromFirestore(Map<String, dynamic> map) {
    return this.fromMap(map);
  }

  @override
  Map<String, dynamic> toFirestore() {
    return this.toMap();
  }
}

class Todo {
  String title;
  bool complete;
  int order;

  Todo({
    this.title,
    this.complete,
    this.order,
  });
  Todo.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('title')) title = map['title'];
    if (map.containsKey('complete')) complete = map['complete'];
    if (map.containsKey('order')) order = map['order'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (title != null) data['title'] = this.title;
    if (complete != null) data['complete'] = this.complete;
    if (order != null) data['order'] = this.order;
    return data;
  }
}

class Feed {
  UserKabanRef author;
  String description;
  String link;
  dynamic created;

  Feed({
    this.description,
    this.author,
    this.created,
    this.link,
  });
  Feed.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('description')) description = map['description'];
    created = map.containsKey('created') && map['created'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            map['created'].millisecondsSinceEpoch)
        : null;
    author = map.containsKey('author') && map['author'] != null
        ? UserKabanRef.fromMap(map['author'])
        : null;
    if (map.containsKey('link')) link = map['link'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (description != null) data['description'] = this.description;
    if (created != null) data['created'] = this.created;
    if (link != null) data['link'] = this.link;
    if (this.author != null) {
      data['author'] = this.author.toMap();
    }
    return data;
  }
}
