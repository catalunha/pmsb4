import 'package:firebase_auth/firebase_auth.dart';

class UserAction {}

class UserLoginEmailPassword extends UserAction {
  final String email;
  final String password;

  UserLoginEmailPassword({this.email, this.password});
  @override
  String toString() {
    return 'UserLoginEmailPassword{email:$email,password:$password}';
  }
}

class UserLoginGoogle extends UserAction {}

class UserLoginSuccessful extends UserAction {
  final FirebaseUser firebaseUser;

  UserLoginSuccessful({this.firebaseUser});
  @override
  String toString() {
    return 'UserLoginSuccessful{firebaseUser: $firebaseUser}';
  }
}

class UserLoginFail extends UserAction {
  final dynamic error;

  UserLoginFail({this.error});

  @override
  String toString() {
    return 'UserLoginFail{error: $error}';
  }
}

class UserLogout extends UserAction {}

class UserLogoutSuccessful extends UserAction {
  UserLogoutSuccessful();
  @override
  String toString() {
    return 'UserLogoutSuccessful{firebaseUser:null}';
  }
}
