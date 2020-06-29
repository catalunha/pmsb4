import 'package:pmsb4/actions/logged_action.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:pmsb4/states/logged_state.dart';
import 'package:redux/redux.dart';

final loggedReducer = combineReducers<LoggedState>([
  TypedReducer<LoggedState, AuthenticationStatusLoggedAction>(
      _authenticationStatusLoggedAction),
  TypedReducer<LoggedState, UpdateProfileSuccessfulLoggedAction>(
      _updateProfileSuccessfulLoggedAction),
  TypedReducer<LoggedState, LoginSuccessfulLoggedAction>(
      _loginSuccessfulLoggedAction),
  TypedReducer<LoggedState, LoginFailLoggedAction>(_loginFailLoggedAction),
  TypedReducer<LoggedState, LogoutSuccessfulLoggedAction>(
      _logoutSuccessfulLoggedAction),
]);

LoggedState _updateProfileSuccessfulLoggedAction(
    LoggedState state, UpdateProfileSuccessfulLoggedAction action) {
  print('_userUpdateProfileSuccessfulAction...');
  return state.copyWith(firebaseUser: action.firebaseUser);
}

LoggedState _authenticationStatusLoggedAction(
    LoggedState state, AuthenticationStatusLoggedAction action) {
  print('_userAuthenticationStatusAction...');
  return state.copyWith(
      authenticationStatus: action.loggedAuthenticationStatus);
}

LoggedState _loginSuccessfulLoggedAction(
    LoggedState state, LoginSuccessfulLoggedAction action) {
  print('_userLoginSuccessfulAction...');
  return state.copyWith(
      authenticationStatus: LoggedAuthenticationStatus.authenticated,
      firebaseUser: action.firebaseUser);
}

LoggedState _logoutSuccessfulLoggedAction(
    LoggedState state, LogoutSuccessfulLoggedAction action) {
  print('_userLogoutSuccessfulAction...');
  return state.copyWith(
      authenticationStatus: LoggedAuthenticationStatus.unInitialized,
      firebaseUser: null);
}

LoggedState _loginFailLoggedAction(
    LoggedState state, LoginFailLoggedAction action) {
  print('_userLoginFailAction...');
  return state.copyWith(
    authenticationStatus: LoggedAuthenticationStatus.unAuthenticated,
    firebaseUser: null,
  );
}
