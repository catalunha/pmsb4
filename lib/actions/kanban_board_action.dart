import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/states/enums.dart';

class KanbanBoardAction {}

/// +++ Actions atendidas pelo KanbanBoardReducer
class AllKanbanBoardModelAction extends KanbanBoardAction {
  final List<KanbanBoardModel> allKanbanBoardModel;

  AllKanbanBoardModelAction({this.allKanbanBoardModel});
}

class UpdateKanbanBoardFilterAction extends KanbanBoardAction {
  final KanbanBoardFilter kanbanBoardFilter;

  UpdateKanbanBoardFilterAction({this.kanbanBoardFilter});
}

class CurrentKanbanBoardModelAction extends KanbanBoardAction {
  final String id;
  CurrentKanbanBoardModelAction({this.id});
}

class AddUserToTeamKanbanBoardModelAction extends KanbanBoardAction {
  final Team team;
  AddUserToTeamKanbanBoardModelAction({this.team});
}

class RemoveUserToTeamKanbanBoardModelAction extends KanbanBoardAction {
  final String id;
  RemoveUserToTeamKanbanBoardModelAction({this.id});
}

// +++ Actions atendidas pelo firebaseFirestoreKanbanBoardMiddleware

class StreamKanbanBoardDataAction extends KanbanBoardAction {}

class AddKanbanBoardDataAction extends KanbanBoardAction {
  final KanbanBoardModel kanbanBoardModel;

  AddKanbanBoardDataAction({this.kanbanBoardModel});
}

class UpdateKanbanBoardDataAction extends KanbanBoardAction {
  final KanbanBoardModel kanbanBoardModel;
  UpdateKanbanBoardDataAction({this.kanbanBoardModel});
}

class DeleteKanbanBoardDataAction extends KanbanBoardAction {
  final String id;

  DeleteKanbanBoardDataAction({this.id});
}
