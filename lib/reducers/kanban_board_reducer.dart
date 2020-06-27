import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/references_models.dart';

import 'package:pmsb4/states/kanban_board_state.dart';
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
  KanbanBoardState _stateNew =
      state.copyWith(allKanbanBoardModel: action.allKanbanBoardModel);
  _stateNew = _updateKanbanBoardFilterAction(
      _stateNew,
      UpdateKanbanBoardFilterAction(
          kanbanBoardFilter: _stateNew.kanbanBoardFilter));
  _stateNew=_currentKanbanBoardModelAction(_stateNew,
      CurrentKanbanBoardModelAction(id: _stateNew.currentKanbanBoardModel?.id));
  return _stateNew;
}

KanbanBoardState _currentKanbanBoardModelAction(
    KanbanBoardState state, CurrentKanbanBoardModelAction action) {
  print('_currentKanbanBoardModelAction...');
  KanbanBoardModel _currentKanbanBoardModel = action.id != null
      ? state.allKanbanBoardModel
          .firstWhere((element) => element.id == action.id)
      : KanbanBoardModel(null);
  return state.copyWith(currentKanbanBoardModel: _currentKanbanBoardModel);
}

KanbanBoardState _updateKanbanBoardFilterAction(
    KanbanBoardState state, UpdateKanbanBoardFilterAction action) {
  print('_updateKanbanBoardFilterAction...');
  // Como o KanbanBoard nao tem filtro dentro de all a cada filtro busca nova lista no firebase.
  return state.copyWith(
      kanbanBoardFilter: action.kanbanBoardFilter,
      filteredKanbanBoardModel: state.allKanbanBoardModel);
}

KanbanBoardState _addUserToTeamKanbanBoardModelAction(
    KanbanBoardState state, AddUserToTeamKanbanBoardModelAction action) {
  print('_addUserToTeamKanbanBoardModelAction...');
  KanbanBoardModel currentKanbanBoardModel = state.currentKanbanBoardModel;
  if (currentKanbanBoardModel?.team == null ||
      !currentKanbanBoardModel.team.containsKey(action.userKabanRef.id)) {
    if (currentKanbanBoardModel?.team == null) {
      currentKanbanBoardModel.team = Map<String, UserKabanRef>();
    }
    currentKanbanBoardModel.team[action.userKabanRef.id] = action.userKabanRef;
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
