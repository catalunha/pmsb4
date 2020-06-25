import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/enums_models.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_crud_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

class _ViewModel {
  final bool isEditing;
  final String title;
  final String description;
  final bool priority;
  final bool active;
  final List<UserKabanRef> team;

  final Function(String, String, bool, bool) onCreate;
  final Function(String, String, bool, bool) onUpdate;

  _ViewModel({
    this.isEditing,
    this.title,
    this.description,
    this.priority,
    this.active,
    this.team,
    this.onCreate,
    this.onUpdate,
  });
  static _ViewModel fromStore(Store<AppState> store, String id) {
    KanbanCardModel _kanbanCardModel =
        store.state.kanbanCardState.currentKanbanCardModel;
    return _ViewModel(
      isEditing: _kanbanCardModel?.id != null ? true : false,
      title: _kanbanCardModel?.title ?? '',
      description: _kanbanCardModel?.description ?? '',
      priority: _kanbanCardModel?.priority ?? false,
      active: _kanbanCardModel?.active ?? false,
      team: _kanbanCardModel.team != null
          ? _kanbanCardModel.team.entries.map((e) => e.value).toList()
          : [],
      onCreate: (String title, String description, bool priority, bool active) {
        // _kanbanCardModel = KanbanCardModel(null);
        _kanbanCardModel.kanbanBoard = store.state.kanbanBoardState.currentKanbanBoardModel.id;
        _kanbanCardModel.title = title;
        _kanbanCardModel.description = description;
        _kanbanCardModel.stageCard = StageCard.todo.toString();
        _kanbanCardModel.priority = false;
        _kanbanCardModel.active = true;
        _kanbanCardModel.created = DateTime.now();
        _kanbanCardModel.author = UserKabanRef(
          id: store.state.userState.firebaseUser.uid,
          displayName: store.state.userState.firebaseUser.displayName,
          photoUrl: store.state.userState.firebaseUser.photoUrl,
        );
        store.dispatch(AddKanbanCardAction(kanbanCardModel: _kanbanCardModel));
      },
      onUpdate: (String title, String description, bool priority, bool active) {
        _kanbanCardModel.title = title;
        _kanbanCardModel.description = description;
        _kanbanCardModel.priority = priority;
        _kanbanCardModel.active = active;
        store.dispatch(
            UpdateKanbanCardAction(kanbanCardModel: _kanbanCardModel));
      },
    );
  }
}

class KanbanCardCRUD extends StatelessWidget {
  final String id;

  const KanbanCardCRUD({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, id),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return KanbanCardCRUDDS(
          isEditing: _viewModel.isEditing,
          title: _viewModel.title,
          description: _viewModel.description,
          priority: _viewModel.priority,
          active: _viewModel.active,
          team: _viewModel.team,
          onCreate: _viewModel.onCreate,
          onUpdate: _viewModel.onUpdate,
        );
      },
      onInit: (Store<AppState> store) {
        store.dispatch(CurrentKanbanCardModelAction(id: id));
      },
    );
  }
}
