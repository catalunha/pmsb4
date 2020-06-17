import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/middlewares/firebase/firestore/collection/collection_model.dart';
import 'package:pmsb4/presentation/collection/collection_update_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final CollectionModel collectionModel;

  _ViewModel({this.collectionModel});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      collectionModel: store.state.collectionState.collectionModel,
    );
  }
}

class CollectionUpdate extends StatelessWidget {
  final int index;

  const CollectionUpdate({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return CollectionUpdateDS(
          index: index,
          collectionModel: _viewModel.collectionModel,
        );
      },
      onInit: (Store<AppState> store) {
        print('CollectionUpdate onInit : $index');
        store.dispatch(CollectionCurrentDocAction(index: index));
      },
    );
  }
}
