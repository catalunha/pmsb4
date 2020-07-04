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
  final Function(String, bool) onActive;
  _ViewModel({
    this.filteredKanbanBoardModel,
    this.onCurrentKanbanBoardModel,
    this.onActive,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      filteredKanbanBoardModel:
          store.state.kanbanBoardState.filteredKanbanBoardModel,
      onCurrentKanbanBoardModel: (String id) {
        store.dispatch(CurrentKanbanBoardModelAction(id: id));
      },
      onActive: (String id, bool active) {
        KanbanBoardModel kanbanBoardModel = store
            .state.kanbanBoardState.allKanbanBoardModel
            .firstWhere((element) => element.id == id);
        kanbanBoardModel.active = active;
        store.dispatch(
            UpdateKanbanBoardDataAction(kanbanBoardModel: kanbanBoardModel));
        store.dispatch(StreamKanbanBoardDataAction());
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
          onActive: _viewModel.onActive,
        );
      },
      onInit: (Store<AppState> store) {
        print('KanbanBoardPage.onInit');
        store.dispatch(StreamKanbanBoardDataAction());
      },
      // onDidChange: (viewModel) {
      //   print('KanbanBoardPage.onDidChange');
      // },
      // onDispose: (store) {
      //   print('KanbanBoardPage.onDispose');
      // },
      // onInitialBuild: (viewModel) {
      //   print('KanbanBoardPage.onInitialBuild');
      // },
      // onWillChange: (previousViewModel, newViewModel) {
      //   print('KanbanBoardPage.onWillChange');
      // },
    );
  }
}
