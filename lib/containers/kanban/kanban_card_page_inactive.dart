import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_board_action.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_page_inactive_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/types_states.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<KanbanCardModel> filteredKanbanCardModel;
  final Function(String) onCurrentKanbanCardModel;
  final Function(String) onActiveTrueCard;

  _ViewModel({
    this.filteredKanbanCardModel,
    this.onCurrentKanbanCardModel,
    this.onActiveTrueCard,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      filteredKanbanCardModel:
          store.state.kanbanCardState.filteredKanbanCardModel,
      onCurrentKanbanCardModel: (String id) {
        store.dispatch(CurrentKanbanCardModelAction(id: id));
      },
      onActiveTrueCard: (String idCard) {
        //print('onActiveTrueCard $idCard');
        KanbanCardModel _currentKanbanCardModel = store
            .state.kanbanCardState.filteredKanbanCardModel
            .firstWhere((element) => element.id == idCard);
        _currentKanbanCardModel.active = true;
        store.dispatch(UpdateKanbanCardDataAction(
            kanbanCardModel: _currentKanbanCardModel));
        KanbanBoardModel _currentKanbanBoardModel =
            store.state.kanbanBoardState.currentKanbanBoardModel;
        if (_currentKanbanBoardModel?.cardOrder != null) {
          Map<String, String> temp = Map<String, String>();
          temp['1'] = idCard;
          _currentKanbanBoardModel.cardOrder.forEach((key, value) {
            temp[(int.parse(key) + 1).toString()] = value;
          });
          _currentKanbanBoardModel.cardOrder.clear();
          _currentKanbanBoardModel.cardOrder.addAll(temp);
          store.dispatch(UpdateKanbanBoardDataAction(
              kanbanBoardModel: _currentKanbanBoardModel));
        }
      },
    );
  }
}

class KanbanCardPageInactive extends StatelessWidget {
  const KanbanCardPageInactive({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return KanbanCardPageInactiveDS(
          filteredKanbanCardModel: _viewModel.filteredKanbanCardModel,
          onCurrentKanbanCardModel: _viewModel.onCurrentKanbanCardModel,
          onActiveTrueCard: _viewModel.onActiveTrueCard,
        );
      },
      onInit: (Store<AppState> store) {
        store.dispatch(UpdateKanbanCardFilterAction(
            kanbanCardFilter: KanbanCardFilter.inactive));
        store.dispatch(StreamKanbanCardDataAction());
      },
    );
  }
}
