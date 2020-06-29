import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/states/enums.dart';

class KanbanBoardState {
  final KanbanBoardFilter kanbanBoardFilter;
  final List<KanbanBoardModel> allKanbanBoardModel;
  final List<KanbanBoardModel> filteredKanbanBoardModel;
  // final List<KanbanBoardModel> selectedKanbanBoardModel;//ainda nao usado neste projeto
  final KanbanBoardModel currentKanbanBoardModel;

  KanbanBoardState({
    this.allKanbanBoardModel,
    this.filteredKanbanBoardModel,
    this.currentKanbanBoardModel,
    this.kanbanBoardFilter,
  });
  factory KanbanBoardState.initial() {
    return KanbanBoardState(
      allKanbanBoardModel: [],
      filteredKanbanBoardModel: [],
      currentKanbanBoardModel: null,
      kanbanBoardFilter: KanbanBoardFilter.active,
    );
  }

  KanbanBoardState copyWith({
    List<KanbanBoardModel> allKanbanBoardModel,
    List<KanbanBoardModel> filteredKanbanBoardModel,
    KanbanBoardModel currentKanbanBoardModel,
    KanbanBoardFilter kanbanBoardFilter,
  }) {
    return KanbanBoardState(
      allKanbanBoardModel: allKanbanBoardModel ?? this.allKanbanBoardModel,
      filteredKanbanBoardModel: filteredKanbanBoardModel ?? this.filteredKanbanBoardModel,
      currentKanbanBoardModel: currentKanbanBoardModel ?? this.currentKanbanBoardModel,
      kanbanBoardFilter: kanbanBoardFilter ?? this.kanbanBoardFilter,
    );
  }

  @override
  int get hashCode =>
      allKanbanBoardModel.hashCode ^
      filteredKanbanBoardModel.hashCode ^
      currentKanbanBoardModel.hashCode ^
      kanbanBoardFilter.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KanbanBoardState &&
          allKanbanBoardModel == other.allKanbanBoardModel &&
          filteredKanbanBoardModel == other.filteredKanbanBoardModel &&
          currentKanbanBoardModel == other.currentKanbanBoardModel &&
          kanbanBoardFilter == other.kanbanBoardFilter&&
          runtimeType == other.runtimeType;
  @override
  String toString() {
    return 'KanbanBoardState{preencher...}';
  }
}
