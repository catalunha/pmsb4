import 'package:firebase_auth/firebase_auth.dart';
class UserAction{}

class UserLogin extends UserAction {}

class UserLoginSuccessful extends UserAction{
  final FirebaseUser firebaseUser;

  UserLoginSuccessful({this.firebaseUser});
  @override
  String toString() {
    return 'UserLoginSuccessful{firebaseUser: $firebaseUser}';
  }
}

class UserLoginFail extends UserAction{
  final dynamic error;

  UserLoginFail({this.error});

  @override
  String toString() {
    return 'UserLoginFail{error: $error}';
  }
}

class UserLogout extends UserAction{}

class UserLogoutSuccessful extends UserAction{
  UserLogoutSuccessful();
  @override
  String toString() {
    return 'UserLogoutSuccessful{firebaseUser:null}';
  }
}
