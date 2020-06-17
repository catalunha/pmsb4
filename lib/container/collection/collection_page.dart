import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/model/collection/collection_model.dart';
import 'package:pmsb4/presentation/collection/collection_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<CollectionModel> listCollectionModel;

  _ViewModel({this.listCollectionModel});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      listCollectionModel: store.state.collectionState.listCollectionModel,
    );
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
          listCollectionModel: _viewModel.listCollectionModel,
        );
      },
      onInit: (Store<AppState> store) {
        store.dispatch(CollectionStreamDocsAction());
      },
    );
  }
}
