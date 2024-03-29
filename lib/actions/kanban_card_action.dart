import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/states/types_states.dart';

class KanbanCardAction {}

/// +++ Actions atendidas pelo KanbanCardReducer

class ReinitializeStatesKanbanCardModelAction extends KanbanCardAction {}

class AllKanbanCardModelAction extends KanbanCardAction {
  final List<KanbanCardModel> allKanbanCardModel;
  final KanbanBoardModel currentKanbanBoardModel;

  AllKanbanCardModelAction(
      {this.allKanbanCardModel, this.currentKanbanBoardModel});
}

class UpdateKanbanCardFilterAction extends KanbanCardAction {
  final KanbanCardFilter kanbanCardFilter;

  UpdateKanbanCardFilterAction({this.kanbanCardFilter});
}

class CurrentKanbanCardModelAction extends KanbanCardAction {
  final String id;
  CurrentKanbanCardModelAction({this.id});
}

class AddUserToTeamKanbanCardModelAction extends KanbanCardAction {
  final Team team;
  AddUserToTeamKanbanCardModelAction({this.team});
}

class RemoveUserToTeamKanbanCardModelAction extends KanbanCardAction {
  final String id;
  RemoveUserToTeamKanbanCardModelAction({this.id});
}

class UpdateTeamKanbanCardFilterAction extends KanbanCardAction {
  final Team currentTeam;
  UpdateTeamKanbanCardFilterAction({this.currentTeam});
}

class UpdateTodoKanbanCardModelAction extends KanbanCardAction {
  final Todo todo;
  UpdateTodoKanbanCardModelAction({this.todo});
}

class RemoveTodoKanbanCardModelAction extends KanbanCardAction {
  final String id;
  RemoveTodoKanbanCardModelAction({this.id});
}

class UpdateFeedKanbanCardModelAction extends KanbanCardAction {
  final Feed feed;
  UpdateFeedKanbanCardModelAction({this.feed});
}

class RemoveFeedKanbanCardModelAction extends KanbanCardAction {
  final String userId;
  final String id;
  RemoveFeedKanbanCardModelAction({this.userId, this.id});
}

class UserViewOrUpdateKanbanCardModelAction extends KanbanCardAction {
  final String user;
  final bool viewer;
  UserViewOrUpdateKanbanCardModelAction({this.user, this.viewer});
}

// +++ Actions atendidas pelo firebaseFirestoreKanbanCardMiddleware

class StreamKanbanCardDataAction extends KanbanCardAction {}

class AddKanbanCardDataAction extends KanbanCardAction {
  final KanbanCardModel kanbanCardModel;
  AddKanbanCardDataAction({this.kanbanCardModel});
}

class UpdateKanbanCardDataAction extends KanbanCardAction {
  final KanbanCardModel kanbanCardModel;
  UpdateKanbanCardDataAction({this.kanbanCardModel});
}
// class UpdateFieldKanbanCardAction extends KanbanCardAction {
//   final Map<String,dynamic> map;
//   UpdateFieldKanbanCardAction({this.map});
// }

class DeleteKanbanCardDataAction extends KanbanCardAction {
  final String id;
  DeleteKanbanCardDataAction({this.id});
}
