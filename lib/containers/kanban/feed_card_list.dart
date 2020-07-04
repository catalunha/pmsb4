import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/feed_card_list_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<Feed> listFeed;
  final Function(String) onDelete;

  _ViewModel({this.listFeed, this.onDelete});
  static _ViewModel fromStore(Store<AppState> store) {
    List<Feed> _listFeed;
    if (store.state.kanbanCardState.currentKanbanCardModel?.feed != null) {
      _listFeed = store
          .state.kanbanCardState.currentKanbanCardModel.feed.entries
          .map((e) => e.value)
          .toList();
      _listFeed.sort((b, a) => (a.created).compareTo(b.created));
    } else {
      _listFeed = [];
    }

    return _ViewModel(
      listFeed: _listFeed,
      onDelete: (String id) {
        KanbanCardModel currentKanbanCardModel =
            store.state.kanbanCardState.currentKanbanCardModel;
        if (currentKanbanCardModel.feed[id].author.id ==
                store.state.loggedState.firebaseUserLogged.uid &&
            !currentKanbanCardModel.feed[id].bot) {
          store.dispatch(RemoveFeedKanbanCardModelAction(
              userId: store.state.loggedState.firebaseUserLogged.uid, id: id));
          store.dispatch(UpdateKanbanCardDataAction(
              kanbanCardModel:
                  store.state.kanbanCardState.currentKanbanCardModel));
        }
      },
    );
  }
}

class FeedCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return FeedCardListDS(
          listFeed: _viewModel.listFeed,
          onDelete: _viewModel.onDelete,
        );
      },
    );
  }
}
