import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/feed_card_crud_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final bool isCreate;
  final String description;
  final String link;
  final Function(String, String) onCreateOrUpdate;

  _ViewModel(
      {this.isCreate, this.description, this.link, this.onCreateOrUpdate});
  static _ViewModel fromStore(Store<AppState> store, String id) {
    Feed feed = id != null
        ? store.state.kanbanCardState.currentKanbanCardModel.feed[id]
        : null;
    return _ViewModel(
      isCreate: id == null ? true : false,
      description: feed?.description ?? '',
      link: feed?.link ?? null,
      onCreateOrUpdate: (String description, String link) {
        Feed feed = Feed();
        feed.id = id;
        feed.description = description;
        feed.link = link.isEmpty || link == '' ? null : link;
        feed.bot = false;
        if (id == null) {
          //create
          final firebaseUser = store.state.loggedState.firebaseUserLogged;
          Team team = Team(
            id: firebaseUser.uid,
            displayName: firebaseUser.displayName,
            photoUrl: firebaseUser.photoUrl,
          );
          feed.author = team;
        }
        store.dispatch(UpdateFeedKanbanCardModelAction(feed: feed));

        store.dispatch(UpdateKanbanCardDataAction(
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
          isCreate: _viewModel.isCreate,
          description: _viewModel.description,
          link: _viewModel.link,
          onCreateOrUpdate: _viewModel.onCreateOrUpdate,
        );
      },
    );
  }
}
