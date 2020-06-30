import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/states/types_states.dart';

class KanbanCardState {
  final KanbanCardFilter kanbanCardFilter;
  final List<KanbanCardModel> allKanbanCardModel;
  final List<KanbanCardModel> filteredKanbanCardModel;
  // final List<KanbanCardModel> selectedKanbanCardModel;//ainda nao usado neste projeto
  final KanbanCardModel currentKanbanCardModel;
  final Team currentTeam;

  KanbanCardState({
    this.allKanbanCardModel,
    this.filteredKanbanCardModel,
    this.currentKanbanCardModel,
    this.kanbanCardFilter,
    this.currentTeam,
  });
  factory KanbanCardState.initial() {
    return KanbanCardState(
      allKanbanCardModel: [],
      filteredKanbanCardModel: [],
      currentKanbanCardModel: null,
      kanbanCardFilter: KanbanCardFilter.all,
      currentTeam: Team(),
    );
  }

  KanbanCardState copyWith({
    List<KanbanCardModel> allKanbanCardModel,
    List<KanbanCardModel> filteredKanbanCardModel,
    KanbanCardModel currentKanbanCardModel,
    KanbanCardFilter kanbanCardFilter,
    Team currentTeam,
  }) {
    return KanbanCardState(
      allKanbanCardModel: allKanbanCardModel ?? this.allKanbanCardModel,
      filteredKanbanCardModel:
          filteredKanbanCardModel ?? this.filteredKanbanCardModel,
      currentKanbanCardModel:
          currentKanbanCardModel ?? this.currentKanbanCardModel,
      kanbanCardFilter: kanbanCardFilter ?? this.kanbanCardFilter,
      currentTeam: currentTeam ?? this.currentTeam,
    );
  }

  @override
  int get hashCode =>
      currentTeam.hashCode ^
      allKanbanCardModel.hashCode ^
      filteredKanbanCardModel.hashCode ^
      currentKanbanCardModel.hashCode ^
      kanbanCardFilter.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KanbanCardState &&
          currentTeam == other.currentTeam &&
          allKanbanCardModel == other.allKanbanCardModel &&
          filteredKanbanCardModel == other.filteredKanbanCardModel &&
          currentKanbanCardModel == other.currentKanbanCardModel &&
          kanbanCardFilter == other.kanbanCardFilter &&
          runtimeType == other.runtimeType;
  @override
  String toString() {
    return 'KanbanCardState{preencher...}';
  }
}
