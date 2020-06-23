import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/states/kanban_board_state.dart';
import 'package:redux/redux.dart';

final kanbanBoardReducer = combineReducers<KanbanBoardState>([
  TypedReducer<KanbanBoardState, AllKanbanBoardModelAction>(
      _allKanbanBoardModelAction),
  TypedReducer<KanbanBoardState, CurrentKanbanBoardModelAction>(
      _currentKanbanBoardModelAction),
  TypedReducer<KanbanBoardState, UpdateKanbanBoardFilterAction>(
      _updateKanbanBoardFilterAction),
]);
KanbanBoardState _allKanbanBoardModelAction(
    KanbanBoardState state, AllKanbanBoardModelAction action) {
  return state.copyWith(allKanbanBoardModel: action.allKanbanBoardModel);
}

KanbanBoardState _currentKanbanBoardModelAction(
    KanbanBoardState state, CurrentKanbanBoardModelAction action) {
  return state.copyWith(
      currentKanbanBoardModel: state.allKanbanBoardModel[action.index]);
}

KanbanBoardState _updateKanbanBoardFilterAction(
    KanbanBoardState state, UpdateKanbanBoardFilterAction action) {
        KanbanBoardState _state =
      state.copyWith(kanbanBoardFilter: action.kanbanBoardFilter);

  return _state;
}
