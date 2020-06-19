import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/states/enums.dart';

@immutable
class UserState {
  final FirebaseUser firebaseUser;
  final AuthenticationStatus authenticationStatus;
  final UserModel userModel;
  UserState({
    this.authenticationStatus,
    this.firebaseUser,
    this.userModel,
  });
  factory UserState.initial() {
    return UserState(
        authenticationStatus: AuthenticationStatus.unInitialized,
        firebaseUser: null,
        userModel: null);
  }
  UserState copyWith(
      {AuthenticationStatus authenticationStatus,
      FirebaseUser firebaseUser,
      UserModel userModel}) {
    return UserState(
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
      firebaseUser: firebaseUser,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  int get hashCode =>
      firebaseUser.hashCode ^
      userModel.hashCode ^
      authenticationStatus.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          firebaseUser == other.firebaseUser &&
          userModel == other.userModel &&
          authenticationStatus == other.authenticationStatus;

  @override
  String toString() {
    return 'UserState{firebaseUser:$firebaseUser,authenticationStatus:$authenticationStatus,userModel:$userModel}';
  }
}
