import 'package:firebase_auth/firebase_auth.dart';

class User {}

class UserLoginSuccessful {
  final FirebaseUser firebaseUser;

  UserLoginSuccessful({this.firebaseUser});
  @override
  String toString() {
    return 'UserLoginSuccessful{firebaseUser: $firebaseUser}';
  }
}

class UserLoginFail {
  final dynamic error;

  UserLoginFail({this.error});

  @override
  String toString() {
    return 'UserLoginFail{error: $error}';
  }
}

class UserLogout {}

class UserLogoutSuccessful {
  UserLogoutSuccessful();
  @override
  String toString() {
    return 'UserLogoutSuccessful{firebaseUser:null}';
  }
}
