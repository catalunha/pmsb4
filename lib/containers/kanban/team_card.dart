import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/team_card_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<Team> teamBoard;
  final List<Team> teamCard;

  final Function(String) addUserTeam;
  _ViewModel({
    this.teamBoard,
    this.teamCard,
    this.addUserTeam,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    List<Team> _teamSorted(Map<String, Team> team) {
      List<Team> _return = [];
      if (team != null) {
        _return = team.entries.map((e) => e.value).toList()
          ..sort((a, b) => a.displayName.compareTo(b.displayName));
      }
      return _return;
    }

    KanbanBoardModel currentKanbanBoardModel =
        store.state.kanbanBoardState.currentKanbanBoardModel;
    KanbanCardModel currentKanbanCardModel =
        store.state.kanbanCardState.currentKanbanCardModel;
    return _ViewModel(
      teamBoard: _teamSorted(currentKanbanBoardModel?.team),
      teamCard: _teamSorted(currentKanbanCardModel?.team),
      addUserTeam: (String id) {
        if (currentKanbanCardModel?.team == null ||
            !currentKanbanCardModel.team.containsKey(id)) {
          //print('addUserTeamCard: Selecionado: $id');
          Team team = currentKanbanBoardModel.team[id];
          store.dispatch(AddUserToTeamKanbanCardModelAction(team: team));
          store.dispatch(UpdateKanbanCardDataAction(
              kanbanCardModel: currentKanbanCardModel));
        } else {
          //print('addUserTeamCard: Já esta no team.');
        }
      },
    );
  }
}

class TeamCard extends StatelessWidget {
  const TeamCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return TeamCardDS(
          teamBoard: _viewModel.teamBoard,
          // selectedUserModel: _viewModel.selectedUserModel,
          teamCard: _viewModel.teamCard,
          addUserTeam: _viewModel.addUserTeam,
        );
      },
    );
  }
}
