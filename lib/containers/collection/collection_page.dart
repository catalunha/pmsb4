import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/models/collection_model.dart';
import 'package:pmsb4/presentations/collection/collection_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<CollectionModel> filteredCollectionModel;
  final Function(bool) filter;
// final Function(bool) selectList;
  _ViewModel({this.filter, this.filteredCollectionModel});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        filteredCollectionModel:
            store.state.collectionState.filteredCollectionModel,
        filter: (bool filter) {
          if (filter) {
            store.dispatch(UpdateCollectionFilterAction(
                collectionFilter: CollectionFilter.checkTrue));
            // store.dispatch(FilteredCollectionModelAction());
          } else {
            store.dispatch(UpdateCollectionFilterAction(
                collectionFilter: CollectionFilter.checkFalse));
            // store.dispatch(FilteredCollectionModelAction());
          }
        });
  }
}

class CollectionPage extends StatelessWidget {
  CollectionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return CollectionPageDS(
          filteredCollectionModel: _viewModel.filteredCollectionModel,
          filter: _viewModel.filter,
        );
      },
      onInit: (Store<AppState> store) {
        store.dispatch(UpdateCollectionFilterAction(
            collectionFilter: CollectionFilter.all));
        store.dispatch(StreamCollectionAction());
      },
    );
  }
}
