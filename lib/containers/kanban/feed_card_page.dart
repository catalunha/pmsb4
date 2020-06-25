import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/presentations/kaban/feed_card_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<Feed> listFeed;
  final Function(String) onDelete;

  _ViewModel({this.listFeed, this.onDelete});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      listFeed: store.state.kanbanCardState.currentKanbanCardModel?.feed != null
          ? store.state.kanbanCardState.currentKanbanCardModel.feed.entries
              .map((e) => e.value)
              .toList()
          : [],
      onDelete: (String id) {
        store.dispatch(RemoveFeedKanbanCardModelAction(userId: store.state.userState.firebaseUser.uid, id: id));
        store.dispatch(UpdateKanbanCardAction(
            kanbanCardModel:
                store.state.kanbanCardState.currentKanbanCardModel));
      },
    );
  }
}

class FeedCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return FeedCardPageDS(
          listFeed: _viewModel.listFeed,
          onDelete: _viewModel.onDelete,
        );
      },
    );
  }
}
