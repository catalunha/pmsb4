import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/team_card_filtering_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final Team currentTeam;
  final List<Team> teamCard;
  final Function(Team) onSelectFilter;

  _ViewModel({
    this.currentTeam,
    this.teamCard,
    this.onSelectFilter,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      currentTeam: store.state.kanbanCardState.currentTeam,
      teamCard: store.state.kanbanBoardState.currentKanbanBoardModel?.team !=
              null
          ? store.state.kanbanBoardState.currentKanbanBoardModel.team.entries
              .map((e) => e.value)
              .toList()
          : [],
      onSelectFilter: (Team currentTeam) {
        store.dispatch(
            UpdateTeamKanbanCardFilterAction(currentTeam: currentTeam));
      },
    );
  }
}

class TeamCardFiltering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return TeamCardFilteringDS(
          currentTeam: _viewModel.currentTeam,
          teamCard: _viewModel.teamCard,
          onSelectFilter: _viewModel.onSelectFilter,
        );
      },
    );
  }
}
