import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseStorageMiddleware() {
  return [
    TypedMiddleware<AppState, UserUpdateProfilePhotoUrlAction>(
        _userUpdateProfilePhotoUrlAction()),
  ];
}

Middleware<AppState> _userUpdateProfilePhotoUrlAction() {
  return (Store<AppState> store, action, NextDispatcher next) {
    print('_userUpdateProfilePhotoUrlAction...');
    final String _photoLocalPath = action.photoLocalPath;
    if (_photoLocalPath != null && _photoLocalPath.isNotEmpty) {
      FirebaseUser firebaseUser = store.state.userState.firebaseUser;

      final File _photoLocalPathFile = File(_photoLocalPath);
      final _photoContentType = lookupMimeType(_photoLocalPath,
          headerBytes: _photoLocalPathFile.readAsBytesSync());
      final String _photoFilename = firebaseUser.uid;

      final FirebaseStorage firebaseStorage = FirebaseStorage();
      final StorageReference storageReference =
          firebaseStorage.ref().child('UserPhotoUrl' + _photoFilename);
      final StorageUploadTask storageUploadTask = storageReference.putFile(
        _photoLocalPathFile,
        StorageMetadata(
          contentType: _photoContentType,
        ),
      );
      storageUploadTask.events.listen((event) async {
        UserUpdateInfo userUpdateInfo = UserUpdateInfo();
        if (event.type == StorageTaskEventType.success) {
          userUpdateInfo.photoUrl = await event.snapshot.ref.getDownloadURL();
          print(userUpdateInfo.photoUrl);
          await firebaseUser.updateProfile(userUpdateInfo).then((value) async {
            firebaseUser.reload();
            FirebaseAuth firebaseAuth = FirebaseAuth.instance;
            firebaseUser = await firebaseAuth.currentUser();
            store.dispatch(
                UserUpdateProfileSuccessfulAction(firebaseUser: firebaseUser));
          }).catchError(
              (onError) => print('_updateprofile onError:' + onError));
        }
      });
    }
    next(action);
  };
}
