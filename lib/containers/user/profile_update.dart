import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/presentations/user/profile_update_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final String displayName;
  final String photoUrl;
  final Function(String, String) updateProfile;

  _ViewModel({
    this.displayName,
    this.photoUrl,
    this.updateProfile,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        displayName: store.state.userState.firebaseUser.displayName,
        photoUrl: store.state.userState.firebaseUser.photoUrl,
        updateProfile: (String displayName, String photoUrl) {
          if (store.state.userState.firebaseUser.displayName != displayName) {
            store.dispatch(UserUpdateProfileDisplayNameAction(
              displayName: displayName,
            ));
          }
          if (photoUrl != null && photoUrl.isNotEmpty) {
            store.dispatch(UserUpdateProfilePhotoUrlAction(
              photoLocalPath: photoUrl,
            ));
          }
        });
  }
}

class ProfileUpdate extends StatelessWidget {
  ProfileUpdate({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel viewModel) {
        return ProfileUpdateDS(
          displayName: viewModel.displayName,
          photoUrl: viewModel.photoUrl,
          updateProfile: viewModel.updateProfile,
        );
      },
    );
  }
}
