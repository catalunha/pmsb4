import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/presentations/kaban/kanban_board_crud_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final bool isEditing;
  final String title;
  final bool public;
  final Function(String, bool) add;
  final Function(String, bool) update;

  _ViewModel({
    this.isEditing,
    this.title,
    this.public,
    this.add,
    this.update,
  });
  static _ViewModel fromStore(Store<AppState> store, int index) {
    KanbanBoardModel _kanbanBoardModel = index != null
        ? store.state.kanbanBoardState.allKanbanBoardModel[index]
        : null;
    return _ViewModel(
      isEditing: index != null ? true : false,
      title: index != null ? _kanbanBoardModel.title : '',
      public: index != null ? _kanbanBoardModel.public : false,
      add: (String title, bool public) {
        KanbanBoardModel kanbanBoardModel = KanbanBoardModel(null);
        kanbanBoardModel.title = title;
        kanbanBoardModel.public = public;
        store
            .dispatch(AddKanbanBoardAction(kanbanBoardModel: kanbanBoardModel));
      },
      update: (String title, bool public) {
        _kanbanBoardModel.title = title;
        _kanbanBoardModel.public = public;
        store.dispatch(
            UpdateKanbanBoardAction(kanbanBoardModel: _kanbanBoardModel));
      },
    );
  }
}

class KanbanBoardCRUD extends StatelessWidget {
  final int index;

  const KanbanBoardCRUD({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, index),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return KanbanBoardCRUDDS(
          isEditing: _viewModel.isEditing,
          title: _viewModel.title,
          add: _viewModel.add,
        );
      },
    );
  }
}
