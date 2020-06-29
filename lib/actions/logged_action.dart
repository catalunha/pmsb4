import 'package:firebase_auth/firebase_auth.dart';
import 'package:pmsb4/states/enums.dart';

class LoggedAction {}

// +++ Actions atendidas por UserReducer
class AuthenticationStatusLoggedAction extends LoggedAction {
  final LoggedAuthenticationStatus loggedAuthenticationStatus;

  AuthenticationStatusLoggedAction({this.loggedAuthenticationStatus});
  @override
  String toString() {
    return 'UserAuthenticationStatus{authenticationStatus:$loggedAuthenticationStatus}';
  }
}

class LoginSuccessfulLoggedAction extends LoggedAction {
  final FirebaseUser firebaseUser;

  LoginSuccessfulLoggedAction({this.firebaseUser});
  @override
  String toString() {
    return 'UserLoginSuccessful{firebaseUser: $firebaseUser}';
  }
}

class UpdateProfileSuccessfulLoggedAction extends LoggedAction {
  final FirebaseUser firebaseUser;

  UpdateProfileSuccessfulLoggedAction({this.firebaseUser});
}

class LoginFailLoggedAction extends LoggedAction {
  final dynamic error;

  LoginFailLoggedAction({this.error});

  @override
  String toString() {
    return 'UserLoginFail{error: $error}';
  }
}

class LogoutSuccessfulLoggedAction extends LoggedAction {
  LogoutSuccessfulLoggedAction();
  @override
  String toString() {
    return 'UserLogoutSuccessful{firebaseUser:null}';
  }
}

// +++ Actions atendidas por firebaseAuthenticationMiddleware

class OnAuthStateChangedLoggedAction extends LoggedAction {}

class SendPasswordResetEmailLoggedAction extends LoggedAction {
  final String email;

  SendPasswordResetEmailLoggedAction({this.email});
  @override
  String toString() {
    return 'UserResetPasswordAction{email:$email}';
  }
}

class UpdateProfileDisplayNameLoggedAction extends LoggedAction {
  final String displayName;

  UpdateProfileDisplayNameLoggedAction({this.displayName});
}

class LoginEmailPasswordLoggedAction extends LoggedAction {
  final String email;
  final String password;

  LoginEmailPasswordLoggedAction({this.email, this.password});
  @override
  String toString() {
    return 'UserLoginEmailPassword{email:$email,password:$password}';
  }
}

class LoginGoogleLoggedAction extends LoggedAction {}

class LogoutLoggedAction extends LoggedAction {}

// +++ Actions atendidas por firebaseStorageMiddleware
class UpdateProfilePhotoUrlLoggedAction extends LoggedAction {
  final String photoLocalPath;

  UpdateProfilePhotoUrlLoggedAction({this.photoLocalPath});
}
