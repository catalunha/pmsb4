import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/type_models.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:pmsb4/states/kanban_card_state.dart';
import 'package:redux/redux.dart';
import 'package:uuid/uuid.dart' as uuid;

final kanbanCardReducer = combineReducers<KanbanCardState>([
  TypedReducer<KanbanCardState, AllKanbanCardModelAction>(
      _allKanbanCardModelAction),
  TypedReducer<KanbanCardState, CurrentKanbanCardModelAction>(
      _currentKanbanCardModelAction),
  TypedReducer<KanbanCardState, UpdateKanbanCardFilterAction>(
      _updateKanbanCardFilterAction),
  TypedReducer<KanbanCardState, AddUserToTeamKanbanCardModelAction>(
      _addUserToTeamKanbanCardModelAction),
  TypedReducer<KanbanCardState, RemoveUserToTeamKanbanCardModelAction>(
      _removeUserToTeamKanbanCardModelAction),
  TypedReducer<KanbanCardState, UpdateTodoKanbanCardModelAction>(
      _updateTodoKanbanCardModelAction),
  TypedReducer<KanbanCardState, RemoveTodoKanbanCardModelAction>(
      _removeTodoKanbanCardModelAction),
  TypedReducer<KanbanCardState, UpdateFeedKanbanCardModelAction>(
      _updateFeedKanbanCardModelAction),
  TypedReducer<KanbanCardState, RemoveFeedKanbanCardModelAction>(
      _removeFeedKanbanCardModelAction),
  TypedReducer<KanbanCardState, UserViewOrUpdateKanbanCardModelAction>(
      _userViewOrUpdateKanbanCardModelAction),
]);
KanbanCardState _allKanbanCardModelAction(
    KanbanCardState state, AllKanbanCardModelAction action) {
  print('_allKanbanCardModelAction...');
  KanbanCardState _newState = state.copyWith(
    allKanbanCardModel: action.allKanbanCardModel,
  );
  _newState = _updateKanbanCardFilterAction(
    _newState,
    UpdateKanbanCardFilterAction(kanbanCardFilter: _newState.kanbanCardFilter),
  );
  _newState = _currentKanbanCardModelAction(
    _newState,
    CurrentKanbanCardModelAction(id: _newState.currentKanbanCardModel.id),
  );
  return _newState;
}

KanbanCardState _updateKanbanCardFilterAction(
    KanbanCardState state, UpdateKanbanCardFilterAction action) {
  print('_updateKanbanCardFilterAction...');
  List<KanbanCardModel> _filteredKanbanCardModel = [];
  if (action.kanbanCardFilter == KanbanCardFilter.all) {
    _filteredKanbanCardModel = state.allKanbanCardModel;
  } else if (action.kanbanCardFilter == KanbanCardFilter.active) {
    _filteredKanbanCardModel = state.allKanbanCardModel;
  } else if (action.kanbanCardFilter == KanbanCardFilter.inactive) {
    _filteredKanbanCardModel = state.allKanbanCardModel;
  } else if (action.kanbanCardFilter == KanbanCardFilter.normal) {
    _filteredKanbanCardModel = state.allKanbanCardModel
        .where((element) => element.priority == false)
        .toList();
  } else if (action.kanbanCardFilter == KanbanCardFilter.priority) {
    _filteredKanbanCardModel = state.allKanbanCardModel
        .where((element) => element.priority == true)
        .toList();
  }

  return state.copyWith(
    kanbanCardFilter: action.kanbanCardFilter,
    filteredKanbanCardModel: _filteredKanbanCardModel,
  );
}

KanbanCardState _currentKanbanCardModelAction(
    KanbanCardState state, CurrentKanbanCardModelAction action) {
  print('_currentKanbanCardModelAction...');
  KanbanCardModel _currentKanbanCardModel = action.id != null
      ? state.allKanbanCardModel
          .firstWhere((element) => element.id == action.id)
      : KanbanCardModel(null);
  return state.copyWith(currentKanbanCardModel: _currentKanbanCardModel);
}

KanbanCardState _addUserToTeamKanbanCardModelAction(
    KanbanCardState state, AddUserToTeamKanbanCardModelAction action) {
  print('_addUserToTeamKanbanCardModelAction...');
  KanbanCardModel currentKanbanCardModel = state.currentKanbanCardModel;
  if (currentKanbanCardModel?.team == null ||
      !currentKanbanCardModel.team.containsKey(action.team)) {
    if (currentKanbanCardModel?.team == null) {
      currentKanbanCardModel.team = Map<String, Team>();
    }
    currentKanbanCardModel.team[action.team.id] = action.team;
  }
  return state.copyWith(currentKanbanCardModel: currentKanbanCardModel);
}

KanbanCardState _removeUserToTeamKanbanCardModelAction(
    KanbanCardState state, RemoveUserToTeamKanbanCardModelAction action) {
  print('_removeUserToTeamKanbanCardModelAction...');
  KanbanCardModel currentKanbanCardModel = state.currentKanbanCardModel;
  currentKanbanCardModel.team.remove(action.id);
  return state.copyWith(currentKanbanCardModel: currentKanbanCardModel);
}

KanbanCardState _updateTodoKanbanCardModelAction(
    KanbanCardState state, UpdateTodoKanbanCardModelAction action) {
  print('_removeUserToTeamKanbanCardModelAction...');
  KanbanCardModel _currentKanbanCardModel = state.currentKanbanCardModel;
  Todo _newTodo = action.todo;
  Map<String, Todo> _oldTodos =
      _currentKanbanCardModel?.todo ?? Map<String, Todo>();

  if (_newTodo.id != null && _oldTodos.containsKey(_newTodo.id)) {
    if (_newTodo.complete != null)
      _currentKanbanCardModel.todo[_newTodo.id].complete = _newTodo.complete;
    if (_newTodo.title != null)
      _currentKanbanCardModel.todo[_newTodo.id].title = _newTodo.title;
  } else {
    String _id = (_currentKanbanCardModel?.todoOrder ?? 0 + 1).toString();
    _currentKanbanCardModel.todo[_id] =
        Todo(id: _id, title: _newTodo.title, complete: false);
    _currentKanbanCardModel.todoOrder = int.parse(_id) + 1;
  }

  return state.copyWith(currentKanbanCardModel: _currentKanbanCardModel);
}

KanbanCardState _removeTodoKanbanCardModelAction(
    KanbanCardState state, RemoveTodoKanbanCardModelAction action) {
  print('_removeUserToTeamKanbanCardModelAction...');
  KanbanCardModel _currentKanbanCardModel = state.currentKanbanCardModel;
  _currentKanbanCardModel.todo.remove(action.id);

  return state.copyWith(currentKanbanCardModel: _currentKanbanCardModel);
}

KanbanCardState _updateFeedKanbanCardModelAction(
    KanbanCardState state, UpdateFeedKanbanCardModelAction action) {
  print('_updateFeedKanbanCardModelAction...');
  KanbanCardModel _currentKanbanCardModel = state.currentKanbanCardModel;
  Feed _newFeed = action.feed;
  _currentKanbanCardModel.feed =
      _currentKanbanCardModel?.feed ?? Map<String, Feed>();
  if (_newFeed.description.isEmpty || _newFeed.description == '')
    _newFeed.description = null;
  if (_newFeed?.link != null && (_newFeed.link.isEmpty || _newFeed.link == ''))
    _newFeed.link = null;

  if (_newFeed?.id != null &&
      _currentKanbanCardModel.feed.containsKey(_newFeed.id)) {
    if (_newFeed.description != null)
      _currentKanbanCardModel.feed[_newFeed.id].description =
          _newFeed.description;
    if (_newFeed.link != null)
      _currentKanbanCardModel.feed[_newFeed.id].link = _newFeed.link;
  } else {
    final uuidG = uuid.Uuid();
    _newFeed.id = uuidG.v4();
    _newFeed.created = DateTime.now();
    _currentKanbanCardModel.feed[_newFeed.id] = _newFeed;
  }

  return state.copyWith(currentKanbanCardModel: _currentKanbanCardModel);
}

KanbanCardState _removeFeedKanbanCardModelAction(
    KanbanCardState state, RemoveFeedKanbanCardModelAction action) {
  print('_removeUserToTeamKanbanCardModelAction...');
  KanbanCardModel currentKanbanCardModel = state.currentKanbanCardModel;
  if (currentKanbanCardModel.feed[action.id].author.id == action.userId &&
      !currentKanbanCardModel.feed[action.id].bot) {
    currentKanbanCardModel.feed.remove(action.id);
  }
  return state.copyWith(currentKanbanCardModel: currentKanbanCardModel);
}

KanbanCardState _userViewOrUpdateKanbanCardModelAction(
    KanbanCardState state, UserViewOrUpdateKanbanCardModelAction action) {
  print('_userViewOrUpdateKanbanCardModelAction...');
  KanbanCardModel _currentKanbanCardModel = state.currentKanbanCardModel;
  if (_currentKanbanCardModel.team.containsKey(action.user)) {
    if (action.viewer) {
      //user atual vendo este card. marca como lido.
      _currentKanbanCardModel.team[action.user].readedCard = true;
    } else {
      //user atual update neste card. os demais tem q ler
      _currentKanbanCardModel.team.forEach((key, value) {
        if (key == action.user) {
          value.readedCard = true;
        } else {
          value.readedCard = false;
        }
      });
    }
  }
  return state.copyWith(currentKanbanCardModel: _currentKanbanCardModel);
}
