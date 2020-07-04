import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/kanban_board_crud_ds.dart';
import 'package:pmsb4/presentations/kaban/kanban_board_crud0_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final bool isCreate;
  final String title;
  final String description;
  final bool public;
  final bool active;
  final List<Team> team;
  final Function(String, String, bool, bool) onCreateOrUpdate;
  final Function() onDelete;
  final Function(String) onRemoveUserTeam;

  _ViewModel({
    this.isCreate,
    this.title,
    this.description,
    this.public,
    this.active,
    this.team,
    this.onCreateOrUpdate,
    this.onDelete,
    this.onRemoveUserTeam,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    KanbanBoardModel _currentKanbanBoardModel =
        store.state.kanbanBoardState.currentKanbanBoardModel;
    bool _isCreate = _currentKanbanBoardModel.id == null ? true : false;
    return _ViewModel(
        isCreate: _isCreate,
        title: _currentKanbanBoardModel?.title ?? '',
        description: _currentKanbanBoardModel?.description ?? '',
        public: _currentKanbanBoardModel?.public ?? false,
        active: _currentKanbanBoardModel?.active ?? true,
        team: _currentKanbanBoardModel.team != null
            ? _currentKanbanBoardModel.team.entries.map((e) => e.value).toList()
            : [],
        onCreateOrUpdate:
            (String title, String description, bool public, bool active) {
          _currentKanbanBoardModel.title = title;
          _currentKanbanBoardModel.description = description;
          _currentKanbanBoardModel.public = public;
          _currentKanbanBoardModel.active = active;
          if (_isCreate) {
            FirebaseUser firebaseUser =
                store.state.loggedState.firebaseUserLogged;
            _currentKanbanBoardModel.author = Team(
              id: firebaseUser.uid,
              displayName: firebaseUser.displayName,
              photoUrl: firebaseUser.photoUrl,
            );
            _currentKanbanBoardModel.created = DateTime.now();
            Team team = Team(
              id: firebaseUser.uid,
              displayName: firebaseUser.displayName,
              photoUrl: firebaseUser.photoUrl,
            );
            store.dispatch(AddUserToTeamKanbanBoardModelAction(team: team));
            store.dispatch(AddKanbanBoardDataAction(
                kanbanBoardModel: _currentKanbanBoardModel));
          } else {
            store.dispatch(UpdateKanbanBoardDataAction(
                kanbanBoardModel: _currentKanbanBoardModel));
          }
        },
        onDelete: () {
          store.dispatch(
              DeleteKanbanBoardDataAction(id: _currentKanbanBoardModel.id));
        },
        onRemoveUserTeam: (String id) {
          store.dispatch(RemoveUserToTeamKanbanBoardModelAction(id: id));
        });
  }
}

class KanbanBoardCRUD extends StatelessWidget {
  const KanbanBoardCRUD({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return KanbanBoardCRUDDS(
          isCreate: _viewModel.isCreate,
          title: _viewModel.title,
          description: _viewModel.description,
          public: _viewModel.public,
          active: _viewModel.active,
          team: _viewModel.team,
          onCreateOrUpdate: _viewModel.onCreateOrUpdate,
          onRemoveUserTeam: _viewModel.onRemoveUserTeam,
        );
      },
    );
  }
}
