import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:pmsb4/states/user_state.dart';
import 'package:redux/redux.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UserAuthenticationStatusAction>(_authentication),
  TypedReducer<UserState, UserUpdateProfileSuccessfulAction>(_updateProfile),
  TypedReducer<UserState, UserLoginSuccessfulAction>(_login),
  TypedReducer<UserState, UserLoginFailAction>(_loginFail),
  TypedReducer<UserState, UserLogoutSuccessfulAction>(_logout),
]);

UserState _updateProfile(
    UserState state, UserUpdateProfileSuccessfulAction action) {
  return state.copyWith(firebaseUser: action.firebaseUser);
}

UserState _authentication(
    UserState state, UserAuthenticationStatusAction action) {
  return state.copyWith(authenticationStatus: action.authenticationStatus);
}

UserState _login(UserState state, UserLoginSuccessfulAction action) {
  print(state.authenticationStatus.toString());
  print(state.toString());

  return state.copyWith(
      authenticationStatus: AuthenticationStatus.authenticated,
      firebaseUser: action.firebaseUser);
}

UserState _logout(UserState state, UserLogoutSuccessfulAction action) {
  // print(state.authenticationStatus.toString());
  print(state.toString());
  return state.copyWith(
      authenticationStatus: AuthenticationStatus.unInitialized,
      firebaseUser: null);
}

UserState _loginFail(UserState state, UserLoginFailAction action) {
  print('_loginFail');
  print(state.authenticationStatus.toString());

  return state.copyWith(
    authenticationStatus: AuthenticationStatus.unAuthenticated,
    firebaseUser: null,
  );
}
