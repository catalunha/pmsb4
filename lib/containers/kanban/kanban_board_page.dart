import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/presentations/kaban/kanban_board_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<KanbanBoardModel> filteredKanbanBoardModel;
  final Function(String) onCurrentKanbanBoardModel;
  _ViewModel({this.filteredKanbanBoardModel, this.onCurrentKanbanBoardModel});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      filteredKanbanBoardModel:
          store.state.kanbanBoardState.filteredKanbanBoardModel,
      onCurrentKanbanBoardModel: (String id) {
        store.dispatch(CurrentKanbanBoardModelAction(id: id));
      },
    );
  }
}

class KanbanBoardPage extends StatelessWidget {
  const KanbanBoardPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return KanbanBoardPageDS(
          filteredKanbanBoardModel: _viewModel.filteredKanbanBoardModel,
          onCurrentKanbanBoardModel: _viewModel.onCurrentKanbanBoardModel,
        );
      },
      onInit: (Store<AppState> store) {
        store.dispatch(StreamKanbanBoardAction());
        // TODO: Limpar currentBoard
      },
    );
  }
}
