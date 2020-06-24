import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/states/enums.dart';

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
]);
KanbanBoardState _allKanbanBoardModelAction(
    KanbanBoardState state, AllKanbanBoardModelAction action) {
  print('_allKanbanBoardModelAction...');
  return state.copyWith(allKanbanBoardModel: action.allKanbanBoardModel);
}

KanbanBoardState _currentKanbanBoardModelAction(
    KanbanBoardState state, CurrentKanbanBoardModelAction action) {
  print('_currentKanbanBoardModelAction...');
  KanbanBoardModel _kanbanBoardModel = action.id != null
      ? state.allKanbanBoardModel
          .firstWhere((element) => element.id == action.id)
      : KanbanBoardModel(null);
  return state.copyWith(currentKanbanBoardModel: _kanbanBoardModel);
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
      !currentKanbanBoardModel.team.containsKey(action.userModel.id)) {
    UserKabanRef userKabanRef = UserKabanRef(
      id: action.userModel.id,
      displayName: action.userModel.displayName,
      photoUrl: action.userModel.photoUrl,
    );
    if (currentKanbanBoardModel?.team == null) {
      currentKanbanBoardModel.team = Map<String, UserKabanRef>();
    }
    currentKanbanBoardModel.team[action.userModel.id] = userKabanRef;
  }
  return state.copyWith(currentKanbanBoardModel: currentKanbanBoardModel);
}
