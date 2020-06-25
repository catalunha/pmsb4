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
  currentKanbanCardModel.team.remove(action.id);
  return state.copyWith(currentKanbanCardModel: currentKanbanCardModel);
}
