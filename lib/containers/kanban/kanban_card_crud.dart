import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_crud2_ds.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_crud_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

class _ViewModel {
  final bool isCreate;
  final String title;
  final String description;
  final bool priority;
  final bool active;
  final int todoCompleted;
  final int todoTotal;
  final List<Team> team;

  final Function(String, String, bool, bool) onCreateOrUpdate;
  final Function(String) onRemoveUserTeam;

  _ViewModel({
    this.isCreate,
    this.title,
    this.description,
    this.priority,
    this.active,
    this.team,
    this.onRemoveUserTeam,
    this.todoCompleted,
    this.todoTotal,
    this.onCreateOrUpdate,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    KanbanCardModel _currentKanbanCardModel =
        store.state.kanbanCardState.currentKanbanCardModel;
    String userId = store.state.loggedState.firebaseUserLogged.uid;
    if (_currentKanbanCardModel?.team != null &&
        _currentKanbanCardModel.team.containsKey(userId) &&
        !_currentKanbanCardModel.team[userId].readedCard) {
      store.dispatch(
          UserViewOrUpdateKanbanCardModelAction(user: userId, viewer: true));
      store.dispatch(
          UpdateKanbanCardDataAction(kanbanCardModel: _currentKanbanCardModel));
    }
    bool _isCreate = _currentKanbanCardModel?.id == null ? true : false;
    return _ViewModel(
      isCreate: _isCreate,
      title: _currentKanbanCardModel?.title ?? '',
      description: _currentKanbanCardModel?.description ?? '',
      priority: _currentKanbanCardModel?.priority ?? false,
      active: _currentKanbanCardModel?.active ?? true,
      todoCompleted: _currentKanbanCardModel?.todoCompleted ?? 0,
      todoTotal: _currentKanbanCardModel?.todoTotal ?? 0,
      team: _currentKanbanCardModel.team != null
          ? _currentKanbanCardModel.team.entries.map((e) => e.value).toList()
          : [],
      onCreateOrUpdate:
          (String title, String description, bool priority, bool active) {
        _currentKanbanCardModel.title = title;
        _currentKanbanCardModel.description = description;
        _currentKanbanCardModel.priority = priority;
        _currentKanbanCardModel.active = active;
        if (_isCreate) {
          _currentKanbanCardModel.kanbanBoard =
              store.state.kanbanBoardState.currentKanbanBoardModel.id;
          _currentKanbanCardModel.stageCard = StageCard.story.toString();
          _currentKanbanCardModel.created = DateTime.now();
          FirebaseUser _firebaseUserLogged =
              store.state.loggedState.firebaseUserLogged;
          _currentKanbanCardModel.author = Team(
            id: _firebaseUserLogged.uid,
            displayName: _firebaseUserLogged.displayName,
            photoUrl: _firebaseUserLogged.photoUrl,
          );
          store.dispatch(AddKanbanCardDataAction(
              kanbanCardModel: _currentKanbanCardModel));
        } else {
          store.dispatch(UpdateKanbanCardDataAction(
              kanbanCardModel: _currentKanbanCardModel));
        }
      },
      onRemoveUserTeam: (String id) async {
        print('removendo1 $id');
        store.dispatch(RemoveUserToTeamKanbanCardModelAction(id: id));

        store.dispatch(UpdateKanbanCardDataAction(
            kanbanCardModel: _currentKanbanCardModel));
      },
    );
  }
}

class KanbanCardCRUD extends StatelessWidget {
  const KanbanCardCRUD({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return KanbanCardCRUD2DS(
          isCreate: _viewModel.isCreate,
          title: _viewModel.title,
          description: _viewModel.description,
          priority: _viewModel.priority,
          active: _viewModel.active,
          todoCompleted: _viewModel.todoCompleted,
          todoTotal: _viewModel.todoTotal,
          team: _viewModel.team,
          onCreateOrUpdate: _viewModel.onCreateOrUpdate,
          onRemoveUserTeam: _viewModel.onRemoveUserTeam,
        );
      },
    );
  }
}
