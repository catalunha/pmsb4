import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/middlewares/firebase/firestore/colecao/colecao_model.dart';
import 'package:pmsb4/presentation/colecao/colecao_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<ColecaoModel> listColecaoModel;

  _ViewModel({this.listColecaoModel});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      listColecaoModel: store.state.colecaoState.listColecaoModel,
    );
  }
}

class ColecaoPage extends StatelessWidget {
  ColecaoPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel _viewModel) {
        return ColecaoPageDS(
          listColecaoModel: _viewModel.listColecaoModel,
        );
      },
    );
  }
}
