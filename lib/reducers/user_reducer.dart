import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/states/user_state.dart';
import 'package:redux/redux.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UserLoginSuccessful>(_login),
  TypedReducer<UserState, UserLogoutSuccessful>(_logout),
]);

UserState _login(UserState state, UserLoginSuccessful action) {
  return state.copyWith(firebaseUser: action.firebaseUser);
}

UserState _logout(UserState state, UserLogoutSuccessful action) {
  return state.copyWith(firebaseUser: null);
}
