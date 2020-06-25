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
  String stageCard;
  Map<String, UserKabanRef> team = Map<String, UserKabanRef>();
  Map<String, Todo> todo = Map<String, Todo>();
  Map<String, Feed> feed = Map<String, Feed>();
  //controle da collection
  int todoOrder = 0;
  dynamic created;
  dynamic modified;
  bool active;
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
    this.todo,
    this.feed,
    this.created,
    this.modified,
    this.active,
    this.todoCompleted,
    this.todoTotal,
  }) : super(id);

  @override
  KanbanCardModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('kanbanBoard')) kanbanBoard = map['kanbanBoard'];
    if (map.containsKey('title')) title = map['title'];
    if (map.containsKey('description')) description = map['description'];
    if (map.containsKey('priority')) priority = map['priority'];
    if (map.containsKey('stageCard')) stageCard = map['stageCard'];
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
    }
    if (map["feed"] is Map) {
      feed = Map<String, Feed>();
      for (var item in map["feed"].entries) {
        feed[item.key] = Feed.fromMap(item.value);
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
    if (map.containsKey('todoOrder')) todoOrder = map['todoOrder'];
    if (map.containsKey('todoCompleted')) todoCompleted = map['todoCompleted'];
    if (map.containsKey('todoTotal')) todoTotal = map['todoTotal'];

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (kanbanBoard != null) data['kanbanBoard'] = this.kanbanBoard;
    if (title != null) data['title'] = this.title;
    if (description != null) data['description'] = this.description;
    if (priority != null) data['priority'] = this.priority;
    if (stageCard != null) data['stageCard'] = this.stageCard;
    if (this.author != null) {
      data['author'] = this.author.toMap();
    }
    if (team != null && team is Map) {
      data["team"] = Map<String, dynamic>();
      for (var item in team.entries) {
        data["team"][item.key] = item.value.toMap();
      }
    }
    if (todo != null && todo is Map) {
      data["todo"] = Map<String, dynamic>();
      for (var item in todo.entries) {
        data["todo"][item.key] = item.value.toMap();
      }
    }
    if (feed != null && feed is Map) {
      data["feed"] = Map<String, dynamic>();
      for (var item in feed.entries) {
        data["feed"][item.key] = item.value.toMap();
      }
    }
    if (created != null) data['created'] = this.created;
    if (modified != null) data['modified'] = this.modified;
    if (active != null) data['active'] = this.active;
    if (todoOrder != null) data['todoOrder'] = this.todoOrder;
    if (todoCompleted != null) data['todoCompleted'] = this.todoCompleted;
    if (todoTotal != null) data['todoTotal'] = this.todoTotal;

    return data;
  }

  KanbanCardModel fromFirestore(Map<String, dynamic> map) {
    return this.fromMap(map);
  }

  @override
  Map<String, dynamic> toFirestore() {
    this.modified = DateTime.now();
    return this.toMap();
  }

//   void updateTodo(Todo _todo) {
//     if (todo != null) {
//       todo = Map<String, Todo>();
//     }
//     if (todo.containsKey(_todo.id)) {
//       if (_todo.complete != null) todo[_todo.id].complete = _todo.complete;
//       if (_todo.title != null) todo[_todo.id].title = _todo.title;
//     } else {
//       String _id = (todoOrder ?? 0 + 1).toString();
//       todo[_id].title = _todo.title;
//       todo[_id].complete = false;
//       todo[_id].id = _id;
//     }

//     if (todo != null && todo.isNotEmpty) {
//       todoTotal = todo.length;
//       todoCompleted = todo.entries
//           .where((element) => element.value.complete == true)
//           .length;
//     }
//   }
}

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
}

class Feed {
  UserKabanRef author;
  String description;
  String link;
  dynamic created;
  String id;

  Feed({
    this.description,
    this.author,
    this.link,
    this.id
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
    if (map.containsKey('id')) id = map['id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (description != null) data['description'] = this.description;
    data['created'] = this.created ?? DateTime.now();
    if (link != null) data['link'] = this.link;
    if (id != null) data['id'] = this.id;
    if (this.author != null) {
      data['author'] = this.author.toMap();
    }
    return data;
  }
}
