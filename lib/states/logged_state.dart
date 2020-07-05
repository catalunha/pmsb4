import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/states/types_states.dart';

@immutable
class LoggedState {
  final FirebaseUser firebaseUserLogged;
  final AuthenticationStatus authenticationStatusLogged;
  final UserModel userModelLogged;
  LoggedState({
    this.authenticationStatusLogged,
    this.firebaseUserLogged,
    this.userModelLogged,
  });
  factory LoggedState.initial() {
    return LoggedState(
        authenticationStatusLogged: AuthenticationStatus.unInitialized,
        firebaseUserLogged: null,
        userModelLogged: null);
  }
  LoggedState copyWith(
      {AuthenticationStatus authenticationStatus,
      FirebaseUser firebaseUser,
      UserModel userModelLogged}) {
    return LoggedState(
      authenticationStatusLogged:
          authenticationStatus ?? this.authenticationStatusLogged,
      firebaseUserLogged: firebaseUser,
      userModelLogged: userModelLogged ?? this.userModelLogged,
    );
  }

  @override
  int get hashCode =>
      firebaseUserLogged.hashCode ^
      userModelLogged.hashCode ^
      authenticationStatusLogged.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedState &&
          runtimeType == other.runtimeType &&
          firebaseUserLogged == other.firebaseUserLogged &&
          userModelLogged == other.userModelLogged &&
          authenticationStatusLogged == other.authenticationStatusLogged;

  @override
  String toString() {
    return 'UserState{firebaseUser:$firebaseUserLogged,authenticationStatus:$authenticationStatusLogged,userModel:$userModelLogged}';
  }
}
