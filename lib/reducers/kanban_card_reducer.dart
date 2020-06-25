import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:pmsb4/states/kanban_card_state.dart';
import 'package:redux/redux.dart';

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
]);
KanbanCardState _allKanbanCardModelAction(
    KanbanCardState state, AllKanbanCardModelAction action) {
  print('_allKanbanCardModelAction...');
  return state.copyWith(allKanbanCardModel: action.allKanbanCardModel);
}

KanbanCardState _currentKanbanCardModelAction(
    KanbanCardState state, CurrentKanbanCardModelAction action) {
  print('_currentKanbanCardModelAction...');
  KanbanCardModel _kanbanCardModel = action.id != null
      ? state.allKanbanCardModel
          .firstWhere((element) => element.id == action.id)
      : KanbanCardModel(null);
  return state.copyWith(currentKanbanCardModel: _kanbanCardModel);
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
      filteredKanbanCardModel: _filteredKanbanCardModel);
}

KanbanCardState _addUserToTeamKanbanCardModelAction(
    KanbanCardState state, AddUserToTeamKanbanCardModelAction action) {
  print('_addUserToTeamKanbanCardModelAction...');
  KanbanCardModel currentKanbanCardModel = state.currentKanbanCardModel;
  if (currentKanbanCardModel?.team == null ||
      !currentKanbanCardModel.team.containsKey(action.userKabanRef)) {
    if (currentKanbanCardModel?.team == null) {
      currentKanbanCardModel.team = Map<String, UserKabanRef>();
    }
    currentKanbanCardModel.team[action.userKabanRef.id] = action.userKabanRef;
  }
  return state.copyWith(currentKanbanCardModel: currentKanbanCardModel);
}

KanbanCardState _removeUserToTeamKanbanCardModelAction(
    KanbanCardState state, RemoveUserToTeamKanbanCardModelAction action) {
  print('_removeUserToTeamKanbanCardModelAction...');
  KanbanCardModel currentKanbanCardModel = state.currentKanbanCardModel;
          print('removendo2 ${action.id}');

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
    if (_newTodo.title != null) _currentKanbanCardModel.todo[_newTodo.id].title = _newTodo.title;
  } else {
    String _id = (_currentKanbanCardModel?.todoOrder ?? 0 + 1).toString();
    _currentKanbanCardModel.todo[_id]= Todo(id: _id,title: _newTodo.title,complete: false);
    _currentKanbanCardModel.todoOrder=int.parse(_id)+1;
  }

  if (_oldTodos != null && _oldTodos.isNotEmpty) {
    _currentKanbanCardModel.todoTotal = _oldTodos.length;
    _currentKanbanCardModel.todoCompleted = _oldTodos.entries
        .where((element) => element.value.complete == true)
        .length;
  }
  return state.copyWith(currentKanbanCardModel: _currentKanbanCardModel);
}

KanbanCardState _removeTodoKanbanCardModelAction(
    KanbanCardState state, RemoveTodoKanbanCardModelAction action) {
  print('_removeUserToTeamKanbanCardModelAction...');
  KanbanCardModel _currentKanbanCardModel = state.currentKanbanCardModel;
  _currentKanbanCardModel.todo.remove(action.id);

  if (_currentKanbanCardModel.todo != null && _currentKanbanCardModel.todo.isNotEmpty) {
    _currentKanbanCardModel.todoTotal = _currentKanbanCardModel.todo.length;
    _currentKanbanCardModel.todoCompleted = _currentKanbanCardModel.todo.entries
        .where((element) => element.value.complete == true)
        .length;
  }
  return state.copyWith(currentKanbanCardModel: _currentKanbanCardModel);
}
