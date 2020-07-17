import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/feed_card_create_ds.dart';
import 'package:pmsb4/presentations/kaban/components/feed_card_update_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final String description;
  final String link;
  final Function(String, String) onCreate;
  final Function(String, String) onUpdate;

  _ViewModel({
    this.description,
    this.link,
    this.onCreate,
    this.onUpdate,
  });
  static _ViewModel fromStore(Store<AppState> store, String id) {
    Feed feed = id != null
        ? store.state.kanbanCardState.currentKanbanCardModel.feed[id]
        : Feed(id: null);
    return _ViewModel(
      description: feed?.description ?? '',
      link: feed?.link ?? null,
      onCreate: (String description, String link) {
        //print('+++ FeedCardCRUD.onCreate $description $link');
        feed.description = description;
        feed.link = link;
        feed.bot = false;
        //print('+++ FeedCardCRUD 01');
        print(feed.toMap());
        final firebaseUser = store.state.loggedState.firebaseUserLogged;
        Team team = Team(
          id: firebaseUser.uid,
          displayName: firebaseUser.displayName,
          photoUrl: firebaseUser.photoUrl,
        );
        feed.author = team;
        print(feed.toMap());
        store.dispatch(UpdateFeedKanbanCardModelAction(feed: feed));
        store.dispatch(UserViewOrUpdateKanbanCardModelAction(
            user: store.state.loggedState.firebaseUserLogged.uid,
            viewer: false));

        store.dispatch(UpdateKanbanCardDataAction(
            kanbanCardModel:
                store.state.kanbanCardState.currentKanbanCardModel));
        //print('+++ FeedCardCRUD.onCreate');
      },
      onUpdate: (String description, String link) {
        feed.description = description;
        feed.link = link.isEmpty || link == '' ? null : link;
        feed.bot = false;
        store.dispatch(UpdateFeedKanbanCardModelAction(feed: feed));
        store.dispatch(UserViewOrUpdateKanbanCardModelAction(
            user: store.state.loggedState.firebaseUserLogged.uid,
            viewer: false));

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
        if (id == null) {
          return FeedCardCreateDS(
            onCreate: _viewModel.onCreate,
          );
        } else {
          return FeedCardUpdateDS(
            description: _viewModel.description,
            link: _viewModel.link,
            onUpdate: _viewModel.onUpdate,
          );
        }
      },
    );
  }
}
