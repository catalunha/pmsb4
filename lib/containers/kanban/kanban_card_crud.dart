import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_update_ds.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_create_or_update_title_description.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart' as uuid;

class _ViewModel {
  final String title;
  final String description;
  final bool priority;
  final bool active;
  final int todoCompleted;
  final int todoTotal;
  final List<Team> team;

  final Function(String, String) onCreate;
  final Function(String, String, bool, bool) onUpdate;
  final Function(String) onRemoveUserTeam;

  _ViewModel({
    this.title,
    this.description,
    this.priority,
    this.active,
    this.team,
    this.onRemoveUserTeam,
    this.todoCompleted,
    this.todoTotal,
    this.onCreate,
    this.onUpdate,
  });
  static _ViewModel fromStore(Store<AppState> store, String id) {
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
    return _ViewModel(
      title: _currentKanbanCardModel?.title ?? '',
      description: _currentKanbanCardModel?.description ?? '',
      priority: _currentKanbanCardModel?.priority ?? false,
      active: _currentKanbanCardModel?.active ?? true,
      todoCompleted: _currentKanbanCardModel?.todoCompleted ?? 0,
      todoTotal: _currentKanbanCardModel?.todoTotal ?? 0,
      team: _currentKanbanCardModel.team != null
          ? _currentKanbanCardModel.team.entries.map((e) => e.value).toList()
          : [],
      onCreate: (String title, String description) {
        final uuidG = uuid.Uuid();
        String id = uuidG.v4();
        KanbanCardModel _currentKanbanCardModel = KanbanCardModel(id);
        _currentKanbanCardModel.title = title;
        _currentKanbanCardModel.description = description;
        _currentKanbanCardModel.priority = false;
        _currentKanbanCardModel.active = true;
        _currentKanbanCardModel.stageCard = StageCard.story.toString();
        _currentKanbanCardModel.created = DateTime.now();
        _currentKanbanCardModel.modified = DateTime.now();
        FirebaseUser _firebaseUserLogged =
            store.state.loggedState.firebaseUserLogged;
        _currentKanbanCardModel.author = Team(
          id: _firebaseUserLogged.uid,
          displayName: _firebaseUserLogged.displayName,
          photoUrl: _firebaseUserLogged.photoUrl,
        );
        KanbanBoardModel _currentKanbanBoardModel =
            store.state.kanbanBoardState.currentKanbanBoardModel;
        _currentKanbanCardModel.kanbanBoard = _currentKanbanBoardModel.id;

        if (_currentKanbanBoardModel?.cardOrder != null) {
          Map<String, String> temp = Map<String, String>();
          temp['1'] = id;
          _currentKanbanBoardModel.cardOrder.forEach((key, value) {
            temp[(int.parse(key) + 1).toString()] = value;
          });
          _currentKanbanBoardModel.cardOrder.clear();
          _currentKanbanBoardModel.cardOrder.addAll(temp);
          store.dispatch(UpdateKanbanBoardDataAction(
              kanbanBoardModel: _currentKanbanBoardModel));
        }
        store.dispatch(
            AddKanbanCardDataAction(kanbanCardModel: _currentKanbanCardModel));
      },
      onUpdate: (String title, String description, bool priority, bool active) {
        print('Atualizando $title $description $priority $active');
        if (title != null) _currentKanbanCardModel.title = title;
        if (description != null)
          _currentKanbanCardModel.description = description;
        if (priority != null) _currentKanbanCardModel.priority = priority;
        if (active != null) {
          _currentKanbanCardModel.active = active;
          if (active == false) {
            KanbanBoardModel _currentKanbanBoardModel =
                store.state.kanbanBoardState.currentKanbanBoardModel;
            if (_currentKanbanBoardModel?.cardOrder != null) {
              _currentKanbanBoardModel.cardOrder.removeWhere(
                  (key, value) => value == _currentKanbanCardModel.id);
              store.dispatch(UpdateKanbanBoardDataAction(
                  kanbanBoardModel: _currentKanbanBoardModel));
            }
            store.dispatch(CurrentKanbanCardModelAction(id: null));
          }
        }

        store.dispatch(UpdateKanbanCardDataAction(
            kanbanCardModel: _currentKanbanCardModel));
        print('KanbanCardCRUD.onUpdate finalizado.');
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
  final String id;

  const KanbanCardCRUD({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, id),
      builder: (BuildContext context, _ViewModel _viewModel) {
        if (id == null) {
          return KanbanCardCreateOrUpdateTitleDescriptionDS(
            isCreate: true,
            title: '',
            description: '',
            onCreate: _viewModel.onCreate,
          );
        } else {
          return KanbanCardUpdateDS(
            title: _viewModel.title,
            description: _viewModel.description,
            priority: _viewModel.priority,
            active: _viewModel.active,
            todoCompleted: _viewModel.todoCompleted,
            todoTotal: _viewModel.todoTotal,
            team: _viewModel.team,
            onUpdate: _viewModel.onUpdate,
            onRemoveUserTeam: _viewModel.onRemoveUserTeam,
          );
        }
      },
    );
  }
}
