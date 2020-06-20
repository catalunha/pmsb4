import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/collection_action.dart';
import 'package:pmsb4/models/collection_model.dart';
import 'package:pmsb4/presentations/collection/collection_update_ds.dart';
import 'package:pmsb4/selectors/collection_selector.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final bool isEditing;
  final String letter;
  final bool check;
  final Function(String, bool) add;
  final Function(String, bool) update;
  final Function delete;
/*
Create
Read
Update
Delete
*/
  _ViewModel({
    this.isEditing,
    this.letter,
    this.check,
    this.add,
    this.update,
    this.delete,
  });
  static _ViewModel fromStore(Store<AppState> store, int index) {
    CollectionModel _collectionModel = index != null
        ? collectionCurrentSelectedSelector(store.state.collectionState, index)
        : null;
    return _ViewModel(
        isEditing: index != null ? true : false,
        letter: index != null ? _collectionModel.letter : '',
        check: index != null ? _collectionModel.check : false,
        update: (String letter, bool check) {
          // CollectionModel collectionModel =
          //     CollectionModel(_collectionModel.id);
          _collectionModel.letter = letter;
          _collectionModel.check = check;
          store.dispatch(
              UpdateCollectionAction(collectionModel: _collectionModel));
        },
        add: (String letter, bool check) {
          CollectionModel collectionModel = CollectionModel(null);
          collectionModel.letter = letter;
          collectionModel.check = check;
          store.dispatch(
              AddCollectionAction(collectionModel: collectionModel));
        },
        delete: () {
          store.dispatch(DeleteCollectionAction(id: _collectionModel.id));
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
          check: _viewModel.check,
          add: _viewModel.add,
          update: _viewModel.update,
          delete: _viewModel.delete,
        );
      },
      // onInit: (Store<AppState> store) {
      //   print('CollectionUpdate onInit : $index');
      //   if (index != null)
      //     store.dispatch(CollectionCurrentDocAction(index: index));
      // },
    );
  }
}
