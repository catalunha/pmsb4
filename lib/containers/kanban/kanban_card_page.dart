import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_page_ds.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_page0_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final KanbanBoardModel currentKanbanBoardModel;
  final List<KanbanCardModel> filteredKanbanCardModel;
  final Function(String) onCurrentKanbanCardModel;
  final Function(String, String) onChangeStageCard;
  final Function(Map<String, String>) onChangeCardOrder;

  _ViewModel({
    this.currentKanbanBoardModel,
    this.filteredKanbanCardModel,
    this.onCurrentKanbanCardModel,
    this.onChangeStageCard,
    this.onChangeCardOrder,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      currentKanbanBoardModel:
          store.state.kanbanBoardState.currentKanbanBoardModel,
      filteredKanbanCardModel:
          store.state.kanbanCardState.filteredKanbanCardModel,
      onCurrentKanbanCardModel: (String id) {
        store.dispatch(CurrentKanbanCardModelAction(id: id));
      },
      onChangeStageCard: (String idKanbanCardModel, String newStageCard) {
        KanbanCardModel _currentKanbanCardModel = store
            .state.kanbanCardState.allKanbanCardModel
            .firstWhere((element) => element.id == idKanbanCardModel);
        _currentKanbanCardModel.stageCard = newStageCard;
        store.dispatch(UpdateKanbanCardDataAction(
            kanbanCardModel: _currentKanbanCardModel));
      },
      onChangeCardOrder: (Map<String, String> cardOrder) {
        KanbanBoardModel _currentKanbanBoardModel =
            store.state.kanbanBoardState.currentKanbanBoardModel;
        _currentKanbanBoardModel.cardOrder = cardOrder;
        store.dispatch(UpdateKanbanBoardDataAction(
            kanbanBoardModel: _currentKanbanBoardModel));
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
          currentKanbanBoardModel: _viewModel.currentKanbanBoardModel,
          filteredKanbanCardModel: _viewModel.filteredKanbanCardModel,
          onCurrentKanbanCardModel: _viewModel.onCurrentKanbanCardModel,
          onChangeCardOrder: _viewModel.onChangeCardOrder,
          onChangeStageCard: _viewModel.onChangeStageCard,
        );
      },
      onInit: (Store<AppState> store) {
        store.dispatch(StreamKanbanCardDataAction());
        store.dispatch(StreamKanbanBoardDataAction());
      },
    );
  }
}
