import 'package:firebase_auth/firebase_auth.dart';
import 'package:pmsb4/states/enums.dart';

class UserAction {}
// Actions atendidas por UserReducer
class UserAuthenticationStatusAction extends UserAction {
  final AuthenticationStatus authenticationStatus;

  UserAuthenticationStatusAction({this.authenticationStatus});
  @override
  String toString() {
    return 'UserAuthenticationStatus{authenticationStatus:$authenticationStatus}';
  }
}

class UserLoginSuccessfulAction extends UserAction {
  final FirebaseUser firebaseUser;

  UserLoginSuccessfulAction({this.firebaseUser});
  @override
  String toString() {
    return 'UserLoginSuccessful{firebaseUser: $firebaseUser}';
  }
}

class UserLoginFailAction extends UserAction {
  final dynamic error;

  UserLoginFailAction({this.error});

  @override
  String toString() {
    return 'UserLoginFail{error: $error}';
  }
}

class UserLogoutSuccessfulAction extends UserAction {
  UserLogoutSuccessfulAction();
  @override
  String toString() {
    return 'UserLogoutSuccessful{firebaseUser:null}';
  }
}

// Actions atendidas por firebaseAuthenticationMiddleware

class UserSendPasswordResetEmailAction extends UserAction{
  final String email;

  UserSendPasswordResetEmailAction({this.email});
  @override
  String toString(){
    return 'UserResetPasswordAction{email:$email}';
  }
}

class UserLoginEmailPasswordAction extends UserAction {
  final String email;
  final String password;

  UserLoginEmailPasswordAction({this.email, this.password});
  @override
  String toString() {
    return 'UserLoginEmailPassword{email:$email,password:$password}';
  }
}

class UserLoginGoogleAction extends UserAction {}

class UserLogoutAction extends UserAction {}
