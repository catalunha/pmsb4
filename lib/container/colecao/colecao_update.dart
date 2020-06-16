import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/colecao_action.dart';
import 'package:pmsb4/middlewares/firebase/firestore/colecao/colecao_model.dart';
import 'package:pmsb4/presentation/colecao/colecao_update_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final ColecaoModel colecaoModel;

  _ViewModel({this.colecaoModel});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      colecaoModel: store.state.colecaoState.colecaoModel,
    );
  }
}

class ColecaoUpdate extends StatelessWidget {
  final int index;

  const ColecaoUpdate({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return ColecaoUpdateDS(
          index: index,
          colecaoModel: _viewModel.colecaoModel,
        );
      },
      onInit: (Store<AppState> store) {
        print('ColecaoUpdate onInit : $index');
        store.dispatch(ColecaoCurrentDocAction(index: index));
      },
    );
  }
}
