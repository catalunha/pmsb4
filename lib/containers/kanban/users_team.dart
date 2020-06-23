import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/actions/users_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/presentations/kaban/users_team_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<UserModel> filteredUserModel;
  final List<UserModel> selectedUserModel;
  final Function(String) addUserTeam;
  _ViewModel({
    this.filteredUserModel,
    this.addUserTeam,
    this.selectedUserModel,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    print('UsersTeam');

    //Ler os users do team do quadro e colocar em selectedUserModel
print('selectionados: ${store.state.usersState.selectedUserModel.length}');
    return _ViewModel(
      filteredUserModel: store.state.usersState.filteredUserModel,
      selectedUserModel: store.state.usersState.selectedUserModel ,
      addUserTeam: (String id) {
        KanbanBoardModel currentKanbanBoardModel =
            store.state.kanbanBoardState.currentKanbanBoardModel;
        print('Selecionado: $id');
        if (currentKanbanBoardModel?.team == null ||
            !currentKanbanBoardModel.team.containsKey(id)) {
          UserModel userModel = store.state.usersState.allUserModel
              .firstWhere((element) => element.id == id);
          store.dispatch(
              AddUserToTeamKanbanBoardModelAction(userModel: userModel));
          store.dispatch(AddSelectedUserModelAction(userModel: userModel));
        } else {
          print('ja esta no team');
        }
        // UserModel userModel = store.state.usersState.filteredUserModel[index];
        // UserKabanRef userKabanRef = UserKabanRef(
        //   id: userModel.id,
        //   displayName: userModel.displayName,
        //   photoUrl: userModel.photoUrl,
        // );
        // kanbanBoardModel.team.addAll({userModel.id: userKabanRef});
        // store.dispatch(
        //     UpdateKanbanBoardAction(kanbanBoardModel: kanbanBoardModel));
      },
    );
  }
}

class UsersTeam extends StatelessWidget {
  const UsersTeam({
    Key key,
  }) : super(key: key);
  Future<String> fetchUserOrder() =>
      // Imagine that this function is more complex and slow.
      Future.delayed(
        Duration(seconds: 2),
        () => 'Large Latte',
      );
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return UsersTeamDS(
          filteredUserModel: _viewModel.filteredUserModel,
          selectedUserModel: _viewModel.selectedUserModel,
          addUserTeam: _viewModel.addUserTeam,
        );
      },
      onInit: (Store<AppState> store) async {
        await store.dispatch(StreamUsersAction());
        // await fetchUserOrder();

        // if (store.state.kanbanBoardState.currentKanbanBoardModel?.team !=
        //     null) {
        //   store.state.kanbanBoardState.currentKanbanBoardModel.team
        //       .forEach((key, value) {
        //     print('usersTeam: $key');
        //     store.dispatch(AddSelectedUserModelAction(id: key));
        //   });
        // }
      },
    );
  }
}
