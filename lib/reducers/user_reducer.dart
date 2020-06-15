import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:pmsb4/states/user_state.dart';
import 'package:redux/redux.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UserAuthenticationStatusAction>(_authentication),
  TypedReducer<UserState, UserLoginSuccessful>(_login),
  TypedReducer<UserState, UserLoginFail>(_loginFail),
  TypedReducer<UserState, UserLogoutSuccessful>(_logout),
]);
UserState _authentication(UserState state, UserAuthenticationStatusAction action) {
  return state.copyWith(authenticationStatus: action.authenticationStatus);
}

UserState _login(UserState state, UserLoginSuccessful action) {
  print(state.authenticationStatus.toString());
  print(state.toString());

  return state.copyWith(
      authenticationStatus: AuthenticationStatus.authenticated,
      firebaseUser: action.firebaseUser);
}

UserState _logout(UserState state, UserLogoutSuccessful action) {
  // print(state.authenticationStatus.toString());
  print(state.toString());
  return state.copyWith(
      authenticationStatus: AuthenticationStatus.unInitialized,
      firebaseUser: null);
}

UserState _loginFail(UserState state, UserLoginFail action) {
  print('_loginFail');
  print(state.authenticationStatus.toString());

  return state.copyWith(
    authenticationStatus: AuthenticationStatus.unAuthenticated,
    firebaseUser: null,
  );
}
