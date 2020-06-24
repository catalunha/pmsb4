import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/actions/users_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/models/user_model.dart';
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
  });
  static _ViewModel fromStore(Store<AppState> store, int index) {
    KanbanBoardModel _kanbanBoardModel =
        store.state.kanbanBoardState.currentKanbanBoardModel;
    return _ViewModel(
      isEditing: index != null ? true : false,
      title: _kanbanBoardModel?.title ?? '',
      description: _kanbanBoardModel?.description ?? '',
      public: _kanbanBoardModel?.public ?? false,
      active: _kanbanBoardModel?.active ?? false,
      team: _kanbanBoardModel.team != null ? _kanbanBoardModel.team.entries.map((e) => e.value).toList():[],
      create: (String title, String description, bool public, bool active) {
        _kanbanBoardModel = KanbanBoardModel(null);
        _kanbanBoardModel.author = UserKabanRef(
          id: store.state.userState.firebaseUser.uid,
          displayName: store.state.userState.firebaseUser.displayName,
          photoUrl: store.state.userState.firebaseUser.photoUrl,
        );
        _kanbanBoardModel.title = title;
        _kanbanBoardModel.description = description;
        _kanbanBoardModel.public = public;
        _kanbanBoardModel.active = active;
        _kanbanBoardModel.created = DateTime.now();
        store.dispatch(
            AddKanbanBoardAction(kanbanBoardModel: _kanbanBoardModel));
      },
      update: (String title, String description, bool public, bool active) {
        _kanbanBoardModel.title = title;
        _kanbanBoardModel.description = description;
        _kanbanBoardModel.public = public;
        _kanbanBoardModel.active = active;
        if (_kanbanBoardModel.author == null) {
          _kanbanBoardModel.author = UserKabanRef(
            id: store.state.userState.firebaseUser.uid,
            displayName: store.state.userState.firebaseUser.displayName,
            photoUrl: store.state.userState.firebaseUser.photoUrl,
          );
        }
        store.dispatch(
            UpdateKanbanBoardAction(kanbanBoardModel: _kanbanBoardModel));
      },
      delete: () {
        store.dispatch(DeleteKanbanBoardAction(id: _kanbanBoardModel.id));
      },
    );
  }
}

class KanbanBoardCRUD extends StatelessWidget {
  final int index;

  const KanbanBoardCRUD({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, index),
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
        );
      },
      onInit: (Store<AppState> store) {
        KanbanBoardModel _kanbanBoardModel = index != null
            ? store.state.kanbanBoardState.allKanbanBoardModel[index]
            : KanbanBoardModel(null);
        store.dispatch(
            CurrentKanbanBoardModelAction(kanbanBoardModel: _kanbanBoardModel));
        if (_kanbanBoardModel?.team != null) {
          _kanbanBoardModel.team.forEach((key, value) {
            final userModel = UserModel(
              value.id,
              displayName: value.displayName,
              photoUrl: value.photoUrl,
            );
            store.dispatch(AddSelectedUserModelAction(userModel: userModel));
          });
        }
      },
    );
  }
}
