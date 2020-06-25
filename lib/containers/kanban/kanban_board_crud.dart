import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/presentations/kaban/kanban_board_crud_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final bool isEditing;
  final String title;
  final String description;
  final bool public;
  final bool active;
  final List<UserKabanRef> team;
  final Function(String, String, bool, bool) create;
  final Function(String, String, bool, bool) update;
  final Function() delete;
  final Function(String) removeUserTeam;

  _ViewModel({
    this.isEditing,
    this.title,
    this.description,
    this.public,
    this.active,
    this.team,
    this.create,
    this.update,
    this.delete,
    this.removeUserTeam,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    KanbanBoardModel _currentKanbanBoardModel =
        store.state.kanbanBoardState.currentKanbanBoardModel;
    return _ViewModel(
        isEditing: _currentKanbanBoardModel.id != null ? true : false,
        title: _currentKanbanBoardModel?.title ?? '',
        description: _currentKanbanBoardModel?.description ?? '',
        public: _currentKanbanBoardModel?.public ?? false,
        active: _currentKanbanBoardModel?.active ?? false,
        team: _currentKanbanBoardModel.team != null
            ? _currentKanbanBoardModel.team.entries.map((e) => e.value).toList()
            : [],
        create: (String title, String description, bool public, bool active) {
          final firebaseUser = store.state.userState.firebaseUser;
          // _currentKanbanBoardModel = KanbanBoardModel(null);
          _currentKanbanBoardModel.author = UserKabanRef(
            id: firebaseUser.uid,
            displayName: firebaseUser.displayName,
            photoUrl: firebaseUser.photoUrl,
          );
          _currentKanbanBoardModel.title = title;
          _currentKanbanBoardModel.description = description;
          _currentKanbanBoardModel.public = public;
          _currentKanbanBoardModel.active = active;
          _currentKanbanBoardModel.created = DateTime.now();
          if (_currentKanbanBoardModel?.team == null ||
              !_currentKanbanBoardModel.team.containsKey(firebaseUser.uid)) {
            print('KanbanBoardCRUD: Adicionando team: ${firebaseUser.uid}');
            UserKabanRef userKabanRef = UserKabanRef(
              id: firebaseUser.uid,
              displayName: firebaseUser.displayName,
              photoUrl: firebaseUser.photoUrl,
            );
            store.dispatch(AddUserToTeamKanbanBoardModelAction(
                userKabanRef: userKabanRef));
          } else {
            print('KanbanBoardCRUD: Já esta com vc no team.');
          }

          store.dispatch(
              AddKanbanBoardAction(kanbanBoardModel: _currentKanbanBoardModel));
        },
        update: (String title, String description, bool public, bool active) {
          _currentKanbanBoardModel.title = title;
          _currentKanbanBoardModel.description = description;
          _currentKanbanBoardModel.public = public;
          _currentKanbanBoardModel.active = active;
          if (_currentKanbanBoardModel.author == null) {
            _currentKanbanBoardModel.author = UserKabanRef(
              id: store.state.userState.firebaseUser.uid,
              displayName: store.state.userState.firebaseUser.displayName,
              photoUrl: store.state.userState.firebaseUser.photoUrl,
            );
          }
          store.dispatch(
              UpdateKanbanBoardAction(kanbanBoardModel: _currentKanbanBoardModel));
        },
        delete: () {
          store.dispatch(DeleteKanbanBoardAction(id: _currentKanbanBoardModel.id));
        },
        removeUserTeam: (String id) {
          store.dispatch(RemoveUserToTeamKanbanBoardModelAction(id: id));
        });
  }
}

class KanbanBoardCRUD extends StatelessWidget {
  // final String id;

  const KanbanBoardCRUD({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return KanbanBoardCRUDDS(
          isEditing: _viewModel.isEditing,
          title: _viewModel.title,
          description: _viewModel.description,
          public: _viewModel.public,
          active: _viewModel.active,
          team: _viewModel.team,
          create: _viewModel.create,
          update: _viewModel.update,
          removeUserTeam: _viewModel.removeUserTeam,
        );
      },
      // onInit: (Store<AppState> store) {
      //   store.dispatch(CurrentKanbanBoardModelAction(id: id));
      // },
    );
  }
}
