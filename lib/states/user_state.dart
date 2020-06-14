import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pmsb4/middlewares/firebase/firestore/user/user_model.dart';

@immutable
class UserState {
  final FirebaseUser firebaseUser;
  final UserModel userModel;
  UserState({
    this.firebaseUser,
    this.userModel,
  });
  factory UserState.initial() {
    return UserState(firebaseUser: null, userModel: null);
  }
  UserState copyWith({FirebaseUser firebaseUser, UserModel userModel}) {
    return UserState(firebaseUser: firebaseUser, userModel: userModel);
  }

  @override
  int get hashCode => firebaseUser.hashCode ^ userModel.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          firebaseUser == other.firebaseUser &&
          userModel == other.userModel;
}
