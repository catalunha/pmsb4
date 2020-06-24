import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/states/enums.dart';

class KanbanBoardAction{}

/// +++ Actions atendidas pelo KanbanBoardReducer
class AllKanbanBoardModelAction extends KanbanBoardAction{
  final  List<KanbanBoardModel> allKanbanBoardModel;

  AllKanbanBoardModelAction({this.allKanbanBoardModel});

}
class CurrentKanbanBoardModelAction extends KanbanBoardAction {
  final String id;
  CurrentKanbanBoardModelAction({this.id});
}
class UpdateKanbanBoardFilterAction extends KanbanBoardAction {
  final KanbanBoardFilter kanbanBoardFilter;

  UpdateKanbanBoardFilterAction({this.kanbanBoardFilter});
}

class AddUserToTeamKanbanBoardModelAction extends KanbanBoardAction {
  final UserModel userModel;
  AddUserToTeamKanbanBoardModelAction({this.userModel});
}
class RemoveUserToTeamKanbanBoardModelAction extends KanbanBoardAction {
  final String id;
  RemoveUserToTeamKanbanBoardModelAction({this.id});
}


// +++ Actions atendidas pelo firebaseFirestoreKanbanBoardMiddleware

class StreamKanbanBoardAction extends KanbanBoardAction {}

class AddKanbanBoardAction extends KanbanBoardAction {
  final KanbanBoardModel kanbanBoardModel;

  AddKanbanBoardAction({this.kanbanBoardModel});
}

class UpdateKanbanBoardAction extends KanbanBoardAction {
  final KanbanBoardModel kanbanBoardModel;
  UpdateKanbanBoardAction({this.kanbanBoardModel});
}

class DeleteKanbanBoardAction extends KanbanBoardAction {
  final String id;

  DeleteKanbanBoardAction({this.id});
}

