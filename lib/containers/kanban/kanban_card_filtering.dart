import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_filtering_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/type_states.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final KanbanCardFilter activeFilter;
  final Function(KanbanCardFilter) onSelectFilter;

  _ViewModel({this.onSelectFilter, this.activeFilter});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      activeFilter: store.state.kanbanCardState.kanbanCardFilter,
      onSelectFilter: (KanbanCardFilter filter) {
        store.dispatch(UpdateKanbanCardFilterAction(kanbanCardFilter: filter));
      },
    );
  }
}

class KanbanCardFiltering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return KanbanCardFilteringDS(
          activeFilter: _viewModel.activeFilter,
          onSelectFilter: _viewModel.onSelectFilter,
        );
      },
    );
  }
}
