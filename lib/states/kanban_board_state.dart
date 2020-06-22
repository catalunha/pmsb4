import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/states/enums.dart';

class KanbanBoardState {
  final KanbanBoardModel currentKanbanBoardModel;
  final List<KanbanBoardModel> allKanbanBoardModel;
  final KanbanBoardFilter kanbanBoardFilter;

  KanbanBoardState({
    this.currentKanbanBoardModel,
    this.allKanbanBoardModel,
    this.kanbanBoardFilter,
  });
  factory KanbanBoardState.initial() {
    return KanbanBoardState(
      currentKanbanBoardModel: null,
      allKanbanBoardModel: [],
      kanbanBoardFilter: KanbanBoardFilter.active,
    );
  }

  KanbanBoardState copyWith({
    KanbanBoardModel currentKanbanBoardModel,
    List<KanbanBoardModel> allKanbanBoardModel,
    KanbanBoardFilter kanbanBoardFilter,
  }) {
    return KanbanBoardState(
      currentKanbanBoardModel: currentKanbanBoardModel ?? this.currentKanbanBoardModel,
      allKanbanBoardModel: allKanbanBoardModel ?? this.allKanbanBoardModel,
      kanbanBoardFilter: kanbanBoardFilter ?? this.kanbanBoardFilter,
    );
  }

  @override
  int get hashCode =>
      currentKanbanBoardModel.hashCode ^
      allKanbanBoardModel.hashCode ^
      kanbanBoardFilter.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KanbanBoardState &&
          runtimeType == other.runtimeType &&
          currentKanbanBoardModel == other.currentKanbanBoardModel &&
          allKanbanBoardModel == other.allKanbanBoardModel &&
          kanbanBoardFilter == other.kanbanBoardFilter;
  @override
  String toString() {
    return 'KanbanBoardState{preencher...}';
  }
}
