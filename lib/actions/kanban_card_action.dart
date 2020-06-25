import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/states/enums.dart';

class KanbanCardAction {}

/// +++ Actions atendidas pelo KanbanCardReducer
class AllKanbanCardModelAction extends KanbanCardAction {
  final List<KanbanCardModel> allKanbanCardModel;

  AllKanbanCardModelAction({this.allKanbanCardModel});
}

class CurrentKanbanCardModelAction extends KanbanCardAction {
  final String id;
  CurrentKanbanCardModelAction({this.id});
}

class UpdateKanbanCardFilterAction extends KanbanCardAction {
  final KanbanCardFilter kanbanCardFilter;

  UpdateKanbanCardFilterAction({this.kanbanCardFilter});
}

class AddUserToTeamKanbanCardModelAction extends KanbanCardAction {
  final UserKabanRef userKabanRef;
  AddUserToTeamKanbanCardModelAction({this.userKabanRef});
}

class RemoveUserToTeamKanbanCardModelAction extends KanbanCardAction {
  final String id;
  RemoveUserToTeamKanbanCardModelAction({this.id});
}

class UpdateTodoKanbanCardModelAction extends KanbanCardAction {
  final Todo todo;
  UpdateTodoKanbanCardModelAction({this.todo});
}

// +++ Actions atendidas pelo firebaseFirestoreKanbanCardMiddleware

class StreamKanbanCardAction extends KanbanCardAction {}

class AddKanbanCardAction extends KanbanCardAction {
  final KanbanCardModel kanbanCardModel;
  AddKanbanCardAction({this.kanbanCardModel});
}

class UpdateKanbanCardAction extends KanbanCardAction {
  final KanbanCardModel kanbanCardModel;
  UpdateKanbanCardAction({this.kanbanCardModel});
}

class DeleteKanbanCardAction extends KanbanCardAction {
  final String id;
  DeleteKanbanCardAction({this.id});
}
