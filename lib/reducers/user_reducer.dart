import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:pmsb4/states/user_state.dart';
import 'package:redux/redux.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UserAuthenticationStatusAction>(
      _userAuthenticationStatusAction),
  TypedReducer<UserState, UserUpdateProfileSuccessfulAction>(
      _userUpdateProfileSuccessfulAction),
  TypedReducer<UserState, UserLoginSuccessfulAction>(
      _userLoginSuccessfulAction),
  TypedReducer<UserState, UserLoginFailAction>(_userLoginFailAction),
  TypedReducer<UserState, UserLogoutSuccessfulAction>(
      _userLogoutSuccessfulAction),
]);

UserState _userUpdateProfileSuccessfulAction(
    UserState state, UserUpdateProfileSuccessfulAction action) {
  return state.copyWith(firebaseUser: action.firebaseUser);
}

UserState _userAuthenticationStatusAction(
    UserState state, UserAuthenticationStatusAction action) {
  return state.copyWith(authenticationStatus: action.authenticationStatus);
}

UserState _userLoginSuccessfulAction(
    UserState state, UserLoginSuccessfulAction action) {
  print(state.authenticationStatus.toString());
  print(state.toString());

  return state.copyWith(
      authenticationStatus: AuthenticationStatus.authenticated,
      firebaseUser: action.firebaseUser);
}

UserState _userLogoutSuccessfulAction(
    UserState state, UserLogoutSuccessfulAction action) {
  // print(state.authenticationStatus.toString());
  print(state.toString());
  return state.copyWith(
      authenticationStatus: AuthenticationStatus.unInitialized,
      firebaseUser: null);
}

UserState _userLoginFailAction(UserState state, UserLoginFailAction action) {
  print('_loginFail');
  print(state.authenticationStatus.toString());

  return state.copyWith(
    authenticationStatus: AuthenticationStatus.unAuthenticated,
    firebaseUser: null,
  );
}
