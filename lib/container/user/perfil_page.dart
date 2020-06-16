import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/presentation/user/perfil_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final String uid;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoUrl;

  _ViewModel( {this.uid,this.displayName, this.email, this.phoneNumber, this.photoUrl,});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      uid:store.state.userState.firebaseUser.uid,
        displayName: store.state.userState.firebaseUser.displayName,
        email: store.state.userState.firebaseUser.email,
        phoneNumber: store.state.userState.firebaseUser.phoneNumber,
        photoUrl: store.state.userState.firebaseUser.photoUrl);
  }
}

class PerfilPage extends StatelessWidget {
  PerfilPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,_ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel viewModel) {
        return PerfilPageDS(
          uid: viewModel.uid,
          displayName: viewModel.displayName ?? '',
          email: viewModel.email ?? '',
          phoneNumber: viewModel.phoneNumber ?? '',
          photoUrl: viewModel.photoUrl ?? '',
        );
      },
    );
  }
}
