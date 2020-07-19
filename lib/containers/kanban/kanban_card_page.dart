import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/types_states.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final KanbanBoardModel currentKanbanBoardModel;
  final bool userLogedIsBoardAuthor;

  _ViewModel({
    this.currentKanbanBoardModel,
    this.userLogedIsBoardAuthor,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        currentKanbanBoardModel:
            store.state.kanbanBoardState.currentKanbanBoardModel,
        userLogedIsBoardAuthor:
            store.state.loggedState.firebaseUserLogged.uid ==
                store.state.kanbanBoardState.currentKanbanBoardModel.author.id);
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
          currentKanbanBoardModel: _viewModel.currentKanbanBoardModel,
          userLogedIsBoardAuthor: _viewModel.userLogedIsBoardAuthor,
        );
      },
      onInit: (Store<AppState> store) {
        store.dispatch(ReinitializeStatesKanbanCardModelAction());
        store.dispatch(UpdateKanbanCardFilterAction(
            kanbanCardFilter: KanbanCardFilter.active));
        store.dispatch(StreamKanbanCardDataAction());
      },
    );
  }
}
