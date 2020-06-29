import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/type_models.dart';

import 'package:pmsb4/states/kanban_board_state.dart';
import 'package:pmsb4/states/type_states.dart';
import 'package:redux/redux.dart';

final kanbanBoardReducer = combineReducers<KanbanBoardState>([
  TypedReducer<KanbanBoardState, AllKanbanBoardModelAction>(
      _allKanbanBoardModelAction),
  TypedReducer<KanbanBoardState, CurrentKanbanBoardModelAction>(
      _currentKanbanBoardModelAction),
  TypedReducer<KanbanBoardState, UpdateKanbanBoardFilterAction>(
      _updateKanbanBoardFilterAction),
  TypedReducer<KanbanBoardState, AddUserToTeamKanbanBoardModelAction>(
      _addUserToTeamKanbanBoardModelAction),
  TypedReducer<KanbanBoardState, RemoveUserToTeamKanbanBoardModelAction>(
      _removeUserToTeamKanbanBoardModelAction),
]);
KanbanBoardState _allKanbanBoardModelAction(
    KanbanBoardState state, AllKanbanBoardModelAction action) {
  print('_allKanbanBoardModelAction...');
  KanbanBoardState _newState = state.copyWith(
    allKanbanBoardModel: action.allKanbanBoardModel,
  );
  _newState = _updateKanbanBoardFilterAction(
    _newState,
    UpdateKanbanBoardFilterAction(
        kanbanBoardFilter: _newState.kanbanBoardFilter),
  );
  _newState = _currentKanbanBoardModelAction(
    _newState,
    CurrentKanbanBoardModelAction(id: _newState.currentKanbanBoardModel?.id),
  );
  return _newState;
}

KanbanBoardState _updateKanbanBoardFilterAction(
    KanbanBoardState state, UpdateKanbanBoardFilterAction action) {
  print('_updateKanbanBoardFilterAction...');
  List<KanbanBoardModel> _filteredKanbanBoardModel = [];
  if (action.kanbanBoardFilter == KanbanBoardFilter.all) {
    _filteredKanbanBoardModel = state.allKanbanBoardModel;
  } else if (action.kanbanBoardFilter == KanbanBoardFilter.active) {
    if (state.allKanbanBoardModel.isEmpty) {
      _filteredKanbanBoardModel = [];
    } else {
      _filteredKanbanBoardModel = state.allKanbanBoardModel
          .where((element) => element.active == true)
          .toList();
    }
  } else if (action.kanbanBoardFilter == KanbanBoardFilter.inactive) {
    if (state.allKanbanBoardModel.isEmpty) {
      _filteredKanbanBoardModel = [];
    } else {
      _filteredKanbanBoardModel = state.allKanbanBoardModel
          .where((element) => element.active == false)
          .toList();
    }
  }

  return state.copyWith(
      kanbanBoardFilter: action.kanbanBoardFilter,
      filteredKanbanBoardModel: _filteredKanbanBoardModel);
}

KanbanBoardState _currentKanbanBoardModelAction(
    KanbanBoardState state, CurrentKanbanBoardModelAction action) {
  print('_currentKanbanBoardModelAction...');
  KanbanBoardModel _currentKanbanBoardModel =
      action.id != null && state.allKanbanBoardModel != []
          ? state.allKanbanBoardModel
              .firstWhere((element) => element.id == action.id)
          : KanbanBoardModel(null);
  return state.copyWith(currentKanbanBoardModel: _currentKanbanBoardModel);
}

KanbanBoardState _addUserToTeamKanbanBoardModelAction(
    KanbanBoardState state, AddUserToTeamKanbanBoardModelAction action) {
  print('_addUserToTeamKanbanBoardModelAction...');
  KanbanBoardModel currentKanbanBoardModel = state.currentKanbanBoardModel;
  if (currentKanbanBoardModel?.team == null) {
    currentKanbanBoardModel.team = Map<String, Team>();
  }
  if (!currentKanbanBoardModel.team.containsKey(action.team.id)) {
    currentKanbanBoardModel.team[action.team.id] = action.team;
  }

  return state.copyWith(currentKanbanBoardModel: currentKanbanBoardModel);
}

KanbanBoardState _removeUserToTeamKanbanBoardModelAction(
    KanbanBoardState state, RemoveUserToTeamKanbanBoardModelAction action) {
  print('_removeUserToTeamKanbanBoardModelAction...');
  KanbanBoardModel currentKanbanBoardModel = state.currentKanbanBoardModel;
  currentKanbanBoardModel.team.remove(action.id);
  return state.copyWith(currentKanbanBoardModel: currentKanbanBoardModel);
}
