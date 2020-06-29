import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<KanbanCardModel> filteredKanbanCardModel;
  final Function(String) onCurrentKanbanCardModel;

  _ViewModel({this.filteredKanbanCardModel, this.onCurrentKanbanCardModel});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      filteredKanbanCardModel:
          store.state.kanbanCardState.filteredKanbanCardModel,
      onCurrentKanbanCardModel: (String id) {
        store.dispatch(CurrentKanbanCardModelAction(id: id));
      },
    );
  }
}

class KanbanCardPage extends StatelessWidget {
  const KanbanCardPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return KanbanCardPageDS(
          filteredKanbanCardModel: _viewModel.filteredKanbanCardModel,
          onCurrentKanbanCardModel: _viewModel.onCurrentKanbanCardModel,
        );
      },
      onInit: (Store<AppState> store) {
        store.dispatch(StreamKanbanCardDataAction());
      },
    );
  }
}
