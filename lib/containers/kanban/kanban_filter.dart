import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/presentations/kaban/kanban_filter_cds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/type_states.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final Function(KanbanBoardFilter) onSelectFilter;
  final KanbanBoardFilter activeFilter;

  _ViewModel({this.onSelectFilter, this.activeFilter});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onSelectFilter: (KanbanBoardFilter filter) {
        // Como o KanbanBoard nao tem filtro dentro de all a cada filtro busca nova lista no firebase.
        store
            .dispatch(UpdateKanbanBoardFilterAction(kanbanBoardFilter: filter));
        store.dispatch(StreamKanbanBoardDataAction());
      },
      activeFilter: store.state.kanbanBoardState.kanbanBoardFilter,
    );
  }
}

class KanbanFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return KanbanFilterCDS(
          onSelectFilter: _viewModel.onSelectFilter,
          activeFilter: _viewModel.activeFilter,
        );
      },
    );
  }
}
