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
]);
KanbanBoardState _allKanbanBoardModelAction(
    KanbanBoardState state, AllKanbanBoardModelAction action) {
  return state.copyWith(allKanbanBoardModel: action.allKanbanBoardModel);
}

KanbanBoardState _currentKanbanBoardModelAction(
    KanbanBoardState state, CurrentKanbanBoardModelAction action) {
  return state.copyWith(currentKanbanBoardModel: action.kanbanBoardModel);
}

KanbanBoardState _updateKanbanBoardFilterAction(
    KanbanBoardState state, UpdateKanbanBoardFilterAction action) {
  KanbanBoardState _state =
      state.copyWith(kanbanBoardFilter: action.kanbanBoardFilter);

  return _state;
}

KanbanBoardState _addUserToTeamKanbanBoardModelAction(
    KanbanBoardState state, AddUserToTeamKanbanBoardModelAction action) {
  KanbanBoardModel currentKanbanBoardModel = state.currentKanbanBoardModel;
  if (currentKanbanBoardModel?.team == null ||
      !currentKanbanBoardModel.team.containsKey(action.userModel.id)) {
    UserKabanRef userKabanRef = UserKabanRef(
      id: action.userModel.id,
      displayName: action.userModel.displayName,
      photoUrl: action.userModel.photoUrl,
    );
    print('currentKanbanBoardModel:${currentKanbanBoardModel.id}');
    currentKanbanBoardModel.team[action.userModel.id] = userKabanRef;
  }
  return state.copyWith(currentKanbanBoardModel: currentKanbanBoardModel);
}
