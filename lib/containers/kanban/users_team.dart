import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/actions/users_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/presentations/kaban/users_team_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<UserModel> filteredUserModel;
  // final List<UserModel> selectedUserModel;
  final List<UserKabanRef> team;

  final Function(String) addUserTeam;
  _ViewModel({
    this.filteredUserModel,
    // this.selectedUserModel,
    this.team,
    this.addUserTeam,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    KanbanBoardModel currentKanbanBoardModel =
        store.state.kanbanBoardState.currentKanbanBoardModel;
    return _ViewModel(
      filteredUserModel: store.state.usersState.filteredUserModel,
      // selectedUserModel: store.state.usersState.selectedUserModel ,
      team: currentKanbanBoardModel.team != null
          ? currentKanbanBoardModel.team.entries.map((e) => e.value).toList()
          : [],
      addUserTeam: (String id) {
        if (currentKanbanBoardModel?.team == null ||
            !currentKanbanBoardModel.team.containsKey(id)) {
          print('UsersTeam: Selecionado: $id');
          UserModel userModel = store.state.usersState.allUserModel
              .firstWhere((element) => element.id == id);
          store.dispatch(
              AddUserToTeamKanbanBoardModelAction(userModel: userModel));
        } else {
          print('UsersTeam: Já esta no team.');
        }
      },
    );
  }
}

class UsersTeam extends StatelessWidget {
  const UsersTeam({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return UsersTeamDS(
          filteredUserModel: _viewModel.filteredUserModel,
          // selectedUserModel: _viewModel.selectedUserModel,
          team: _viewModel.team,
          addUserTeam: _viewModel.addUserTeam,
        );
      },
      onInit: (Store<AppState> store) {
        store.dispatch(StreamUsersAction());
      },
    );
  }
}
