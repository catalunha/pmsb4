import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/presentations/logged/profile_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final String uid;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoUrl;

  _ViewModel({
    this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        uid: store.state.loggedState.firebaseUserLogged.uid,
        displayName: store.state.loggedState.firebaseUserLogged.displayName,
        email: store.state.loggedState.firebaseUserLogged.email,
        phoneNumber: store.state.loggedState.firebaseUserLogged.phoneNumber,
        photoUrl: store.state.loggedState.firebaseUserLogged.photoUrl);
  }
}

class ProfilePage extends StatelessWidget {
  ProfilePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel viewModel) {
        return ProfilePageDS(
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
