import 'package:pmsb4/models/firestore_model.dart';
import 'package:pmsb4/models/type_models.dart';

class KanbanCardModel extends FirestoreModel {
  static final String collection = 'kanbanCard';
  String kanbanBoard;
  String title;
  String description;
  bool priority;
  Team author;
  String stageCard;
  Map<String, Team> team = Map<String, Team>();
  Map<String, Todo> todo = Map<String, Todo>();
  Map<String, Feed> feed = Map<String, Feed>();
  int todoOrder;
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
        ? Team.fromMap(map['author'])
        : null;
    if (map["team"] is Map) {
      team = Map<String, Team>();
      for (var item in map["team"].entries) {
        team[item.key] = Team.fromMap(item.value);
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
    updateCompletedTodos();
    if (todoCompleted != null) data['todoCompleted'] = this.todoCompleted;
    if (todoTotal != null) data['todoTotal'] = this.todoTotal;

    return data;
  }

  void updateCompletedTodos() {
    if (this.todo != null) {
      todoTotal = todo.length ?? 0;
      todoCompleted = todo.entries
              .where((element) => element.value.complete == true)
              .length ??
          0;
    }
  }

  KanbanCardModel fromFirestore(Map<String, dynamic> map) {
    return this.fromMap(map);
  }

  @override
  Map<String, dynamic> toFirestore() {
    this.modified = DateTime.now();
    return this.toMap();
  }
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
  Team author;
  String description;
  String link;
  dynamic created;
  String id;
  bool bot;

  Feed({
    this.description,
    this.author,
    this.link,
    this.id,
    this.bot,
  });
  Feed.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('description')) description = map['description'];
    created = (map.containsKey('created') && map['created'] != null)
        ? DateTime.fromMillisecondsSinceEpoch(
            map['created'].millisecondsSinceEpoch)
        : null;
    author = map.containsKey('author') && map['author'] != null
        ? Team.fromMap(map['author'])
        : null;
    if (map.containsKey('link')) link = map['link'];
    if (map.containsKey('id')) id = map['id'];
    if (map.containsKey('bot')) bot = map['bot'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (description != null) data['description'] = this.description;
    if (created != null) data['created'] = this.created;
    if (link != null) data['link'] = this.link;
    if (id != null) data['id'] = this.id;
    if (bot != null) data['bot'] = this.bot;
    if (this.author != null) {
      data['author'] = this.author.toMap();
    }
    return data;
  }
}
