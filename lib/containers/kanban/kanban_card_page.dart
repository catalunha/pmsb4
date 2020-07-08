import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/types_states.dart';
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
        //+++ atualiza o feed
        List<String> stagesLabels = [
          'Pendências', //StageCard.story.toString(),
          'Para fazer', // StageCard.todo.toString(),
          'Fazendo', //StageCard.doing.toString(),
          'Verificando', //StageCard.check.toString(),
          'Concluído', //StageCard.done.toString(),
        ];
        int stageLabelIndex;
        if (newStageCard == StageCard.story.toString()) {
          stageLabelIndex = 0;
        } else if (newStageCard == StageCard.todo.toString()) {
          stageLabelIndex = 1;
        } else if (newStageCard == StageCard.doing.toString()) {
          stageLabelIndex = 2;
        } else if (newStageCard == StageCard.check.toString()) {
          stageLabelIndex = 3;
        } else if (newStageCard == StageCard.done.toString()) {
          stageLabelIndex = 4;
        }

        Feed feed = Feed(id: null);
        feed.description =
            'Cartão foi movido para a coluna: ${stagesLabels[stageLabelIndex]}';
        feed.link = null;
        feed.bot = true;
        final firebaseUser = store.state.loggedState.firebaseUserLogged;
        Team team = Team(
          id: firebaseUser.uid,
          displayName: firebaseUser.displayName,
          photoUrl: firebaseUser.photoUrl,
        );
        feed.author = team;
        store.dispatch(UpdateFeedKanbanCardModelAction(feed: feed));
        //---
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
        store.dispatch(ReinitializeStatesKanbanCardModelAction());
        store.dispatch(UpdateKanbanCardFilterAction(
            kanbanCardFilter: KanbanCardFilter.active));
        store.dispatch(StreamKanbanCardDataAction());
      },
    );
  }
}
