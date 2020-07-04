import 'package:pmsb4/models/firestore_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:sortedmap/sortedmap.dart';

class KanbanCardModel extends FirestoreModel {
  static final String collection = 'kanbanCard';
  String kanbanBoard;
  String title;
  String description;
  bool priority;
  Team author;
  String stageCard;
  Map<String, String> todoOrder = Map<String, String>();
  Map<String, Team> team = Map<String, Team>();
  Map<String, Todo> todo = Map<String, Todo>();
  Map<String, Feed> feed = Map<String, Feed>();
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
    this.todoOrder,
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
    if (map["team"] is Map && map["team"] != null) {
      print('KanbanCardModel 01');
      team = Map<String, Team>();
      for (var item in map["team"].entries) {
        team[item.key] = Team.fromMap(item.value);
      }
      print('KanbanCardModel 02');
    }
    if (map["todoOrder"] is Map && map["todoOrder"] != null) {
      print('KanbanCardModel 03');
      todoOrder = Map<String, String>();
      for (var item in map["todoOrder"].entries) {
        todoOrder[item.key] = item.value;
      }
      print('KanbanCardModel 04');
    }
    if (map["todo"] is Map && map["todo"] != null) {
      print('KanbanCardModel 05');
      todo = Map<String, Todo>();
      if (map.containsKey('todoOrder') &&
          map["todoOrder"] != null &&
          map["todoOrder"].length == map["todo"].length) {
        Map<String, String> todoOrderOrdained = new SortedMap(Ordering.byKey());
        for (var item in map["todoOrder"].entries) {
          todoOrderOrdained[item.key] = item.value;
        }
        for (var item in todoOrderOrdained.entries) {
          todo[item.value] = Todo.fromMap(map["todo"][item.value]);
        }
      } else {
        for (var item in map["todo"].entries) {
          todo[item.key] = Todo.fromMap(item.value);
        }
      }
      print('KanbanCardModel 06');
    }
    updateCompletedTodos();
    if (map["feed"] is Map && map["feed"] != null) {
      print('KanbanCardModel 07');
      feed = Map<String, Feed>();
      for (var item in map["feed"].entries) {
        feed[item.key] = Feed.fromMap(item.value);
      }
      print('KanbanCardModel 08');
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
    if (todoOrder != null && todoOrder is Map) {
      data["todoOrder"] = Map<String, dynamic>();
      for (var item in todoOrder.entries) {
        data["todoOrder"][item.key] = item.value;
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
    } else {
      todoTotal = 0;
      todoCompleted = 0;
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

  @override
  int get hashCode =>
      kanbanBoard.hashCode ^
      title.hashCode ^
      description.hashCode ^
      priority.hashCode ^
      author.hashCode ^
      stageCard.hashCode ^
      team.hashCode ^
      todo.hashCode ^
      todoOrder.hashCode ^
      feed.hashCode ^
      created.hashCode ^
      modified.hashCode ^
      active.hashCode ^
      todoCompleted.hashCode ^
      todoTotal.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KanbanCardModel &&
          kanbanBoard == other.kanbanBoard &&
          title == other.title &&
          description == other.description &&
          priority == other.priority &&
          author == other.author &&
          stageCard == other.stageCard &&
          team == other.team &&
          todo == other.todo &&
          feed == other.feed &&
          todoOrder == other.todoOrder &&
          created == other.created &&
          modified == other.modified &&
          active == other.active &&
          todoCompleted == other.todoCompleted &&
          todoTotal == other.todoTotal;
}
