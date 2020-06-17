import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/model/collection/collection_model.dart';
import 'package:pmsb4/presentation/collection/collection_update_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final bool isEditing;
  final String letter;
  final Function(String) add;
  final Function(String) update;
  final Function delete;

  _ViewModel({
    this.isEditing,
    this.letter,
    this.add,
    this.update,
    this.delete,
  });
  static _ViewModel fromStore(Store<AppState> store, int index) {
    return _ViewModel(
        isEditing: index != null ? true : false,
        letter: index != null
            ? store.state.collectionState.collectionModel.letter
            : '',
        update: (String letter) {
          CollectionModel collectionModel =
              CollectionModel(store.state.collectionState.collectionModel.id);
          collectionModel.letter = letter;
          store.dispatch(
              CollectionUpdateDocAction(collectionModel: collectionModel));
        },
        add: (String letter) {
          CollectionModel collectionModel = CollectionModel(null);
          collectionModel.letter = letter;
          store.dispatch(
              CollectionAddDocAction(collectionModel: collectionModel));
        },
        delete: () {
          store.dispatch(CollectionDeleteDocsAction(
              id: store.state.collectionState.collectionModel.id));
        });
  }
}

class CollectionUpdate extends StatelessWidget {
  final int index;

  const CollectionUpdate({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, index),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return CollectionUpdateDS(
          isEditing: _viewModel.isEditing,
          letter: _viewModel.letter,
          add: _viewModel.add,
          update: _viewModel.update,
          delete: _viewModel.delete,
        );
      },
      onInit: (Store<AppState> store) {
        print('CollectionUpdate onInit : $index');
        if (index != null)
          store.dispatch(CollectionCurrentDocAction(index: index));
      },
    );
  }
}
