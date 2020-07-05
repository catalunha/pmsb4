import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/states/types_states.dart';
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
  TypedReducer<KanbanCardState, UpdateTeamKanbanCardFilterAction>(
      _updateTeamKanbanCardFilterAction),
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
  KanbanCardState _newState = state;
  List<KanbanCardModel> _allKanbanCardModel = [];
  if (action.allKanbanCardModel != null) {
    if (state.kanbanCardFilter == KanbanCardFilter.inactive) {
      _allKanbanCardModel.addAll(action.allKanbanCardModel);
      _newState = state.copyWith(
        allKanbanCardModel: _allKanbanCardModel,
      );

      _newState = _updateKanbanCardFilterAction(
        _newState,
        UpdateKanbanCardFilterAction(
            kanbanCardFilter: _newState.kanbanCardFilter),
      );
      _newState = _currentKanbanCardModelAction(
        _newState,
        CurrentKanbanCardModelAction(id: null),
      );
    } else {
      print('_allKanbanCardModelAction...01');

      KanbanBoardModel kanbanBoardModel = action.currentKanbanBoardModel;
      print('_allKanbanCardModelAction...02');

      if (kanbanBoardModel?.cardOrder != null &&
          kanbanBoardModel.cardOrder.isNotEmpty) {
        print('_allKanbanCardModelAction...03');
        // action.allKanbanCardModel.forEach((element) {
        //   print(element.id);
        // });
        for (var item in kanbanBoardModel.cardOrder.entries) {
          print('_allKanbanCardModelAction...03a ${item.key} ${item.value}');
          _allKanbanCardModel.add(action.allKanbanCardModel
              .firstWhere((element) => element.id == item.value));
        }
        print('_allKanbanCardModelAction...04');
      } else {
        print('_allKanbanCardModelAction...05');
        _allKanbanCardModel.addAll(action.allKanbanCardModel);
      }
      print('_allKanbanCardModelAction...06');
      _newState = state.copyWith(
        allKanbanCardModel: _allKanbanCardModel,
      );

      _newState = _updateKanbanCardFilterAction(
        _newState,
        UpdateKanbanCardFilterAction(
            kanbanCardFilter: _newState.kanbanCardFilter),
      );
      _newState = _currentKanbanCardModelAction(
        _newState,
        CurrentKanbanCardModelAction(id: _newState.currentKanbanCardModel?.id),
      );
    }
  }
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
  if (currentKanbanCardModel?.team == null) {
    currentKanbanCardModel.team = Map<String, Team>();
  }
  if (!currentKanbanCardModel.team.containsKey(action.team.id)) {
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

KanbanCardState _updateTeamKanbanCardFilterAction(
    KanbanCardState state, UpdateTeamKanbanCardFilterAction action) {
  print('_updateTeamKanbanCardFilterAction...');
  List<KanbanCardModel> _filteredKanbanCardModel = [];
  print('_updateTeamKanbanCardFilterAction... ${state.kanbanCardFilter}');
  print('_updateTeamKanbanCardFilterAction... ${action.currentTeam.id}');
  KanbanCardState _newState = _updateKanbanCardFilterAction(
    state,
    UpdateKanbanCardFilterAction(kanbanCardFilter: state.kanbanCardFilter),
  );
  _filteredKanbanCardModel = _newState.filteredKanbanCardModel;
  // if (action.currentTeam == null) {
  //   _newState=state.copyWith(
  //   filteredKanbanCardModel: state.allKanbanCardModel,
  // );
  print('_updateTeamKanbanCardFilterAction...01');
  if (action.currentTeam.id != null) {
    _filteredKanbanCardModel = _newState.filteredKanbanCardModel
        .where((element) =>
            element?.team != null &&
            element.team.containsKey(action.currentTeam.id))
        .toList();
  }
  print('_updateTeamKanbanCardFilterAction...02');

  return state.copyWith(
    currentTeam: action.currentTeam,
    filteredKanbanCardModel: _filteredKanbanCardModel,
  );
}

KanbanCardState _updateTodoKanbanCardModelAction(
    KanbanCardState state, UpdateTodoKanbanCardModelAction action) {
  print('_updateTodoKanbanCardModelAction...');
  KanbanCardModel _currentKanbanCardModel = state.currentKanbanCardModel;
  Todo _newTodo = action.todo;
  if (_currentKanbanCardModel?.todo == null) {
    _currentKanbanCardModel.todo = Map<String, Todo>();
  }

  if (_newTodo.id != null &&
      _currentKanbanCardModel.todo.containsKey(_newTodo.id)) {
    if (_newTodo.complete != null)
      _currentKanbanCardModel.todo[_newTodo.id].complete = _newTodo.complete;
    if (_newTodo.title != null)
      _currentKanbanCardModel.todo[_newTodo.id].title = _newTodo.title;
  } else {
    final uuidG = uuid.Uuid();
    _newTodo.id = uuidG.v4();
    _currentKanbanCardModel.todo[_newTodo.id] =
        Todo(id: _newTodo.id, title: _newTodo.title, complete: false);
    _currentKanbanCardModel.todoOrder =
        _currentKanbanCardModel?.todoOrder ?? Map<String, String>();
    int length = _currentKanbanCardModel.todoOrder.length;
    print('length:$length');
    _currentKanbanCardModel.todoOrder
        .addAll({(++length).toString(): _newTodo.id});
  }
  _currentKanbanCardModel.updateCompletedTodos();
  return state.copyWith(currentKanbanCardModel: _currentKanbanCardModel);
}

KanbanCardState _removeTodoKanbanCardModelAction(
    KanbanCardState state, RemoveTodoKanbanCardModelAction action) {
  print('_removeTodoKanbanCardModelAction...');
  KanbanCardModel _currentKanbanCardModel = state.currentKanbanCardModel;
  _currentKanbanCardModel.todo.remove(action.id);
  _currentKanbanCardModel.todoOrder
      .removeWhere((key, value) => value == action.id);
  _currentKanbanCardModel.updateCompletedTodos();

  return state.copyWith(currentKanbanCardModel: _currentKanbanCardModel);
}

KanbanCardState _updateFeedKanbanCardModelAction(
    KanbanCardState state, UpdateFeedKanbanCardModelAction action) {
  print('_updateFeedKanbanCardModelAction...');
  KanbanCardModel _currentKanbanCardModel = state.currentKanbanCardModel;
  Feed _newFeed = action.feed;
  _currentKanbanCardModel.feed =
      _currentKanbanCardModel?.feed ?? Map<String, Feed>();
  // if (_newFeed.description.isEmpty || _newFeed.description == '')
  //   _newFeed.description = null;
  // if (_newFeed.link != null && (_newFeed.link.isEmpty || _newFeed.link == ''))
  //   _newFeed.link = null;

  if (_newFeed?.id != null &&
      _currentKanbanCardModel.feed.containsKey(_newFeed.id)) {
    // if (_newFeed.description != null)
    _currentKanbanCardModel.feed[_newFeed.id].description =
        _newFeed.description;
    // if (_newFeed.link !=null)
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
