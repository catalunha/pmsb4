import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/presentations/kaban/feed_card_crud_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final bool isEditing;
  final String description;
  final String link;
  final Function(String, String) onCreateOrUpdate;

  _ViewModel(
      {this.isEditing, this.description, this.link, this.onCreateOrUpdate});
  static _ViewModel fromStore(Store<AppState> store, String id) {
    Feed feed = id != null
        ? store.state.kanbanCardState.currentKanbanCardModel.feed[id]
        : null;
    return _ViewModel(
      isEditing: id != null ? true : false,
      description: feed?.description ?? '',
      link: feed?.link ?? null,
      onCreateOrUpdate: (String description, String link) {
        Feed feed = Feed();
        if (id == null) {
          //create
          final firebaseUser = store.state.userState.firebaseUser;
          UserKabanRef userKabanRef = UserKabanRef(
            id: firebaseUser.uid,
            displayName: firebaseUser.displayName,
            photoUrl: firebaseUser.photoUrl,
          );
          feed.author = userKabanRef;
          feed.description = description;
          feed.link = link;
        } else {
          //update
          feed.id = id;
          feed.description = description;
          feed.link = link;
        }
        store.dispatch(UpdateFeedKanbanCardModelAction(feed: feed));

        store.dispatch(UpdateKanbanCardAction(
            kanbanCardModel:
                store.state.kanbanCardState.currentKanbanCardModel));
      },
    );
  }
}

class FeedCardCRUD extends StatelessWidget {
  final String id;

  const FeedCardCRUD({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, id),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return FeedCardCRUDDS(
          isEditing: _viewModel.isEditing,
          description: _viewModel.description,
          link: _viewModel.link,
          onCreateOrUpdate: _viewModel.onCreateOrUpdate,
        );
      },
    );
  }
}
