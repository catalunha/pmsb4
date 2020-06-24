import 'package:pmsb4/actions/users_action.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:pmsb4/states/users_state.dart';
import 'package:redux/redux.dart';

final usersReducer = combineReducers<UsersState>([
  TypedReducer<UsersState, AllUsersModelAction>(_allUsersModelAction),
  // TypedReducer<UsersState, CurrentUsersModelAction>(
  //     _currentUsersModelAction),
  TypedReducer<UsersState, UpdateUsersFilterAction>(_updateUsersFilterAction),
  // TypedReducer<UsersState, AddSelectedUserModelAction>(
  //     _addSelectedUserModelAction),
  // TypedReducer<UsersState, FilteredUsersModelAction>(
  //     _filteredUsersModelAction),
]);

UsersState _allUsersModelAction(UsersState state, AllUsersModelAction action) {
  return state.copyWith(allUserModel: action.allUserModel);
}

// UsersState _currentUsersModelAction(
//     UsersState state, CurrentUsersModelAction action) {
//   // print('_currentUsersModelAction:${state.allUsersModel}');
//   return state.copyWith(
//       UsersModel: state.allUsersModel[action.index]);
// }

// UsersState _updateUsersFilterAction(
//     UsersState state, UpdateUsersFilterAction action) {
//       print(action.UsersFilter);
//   UsersState _state =
//       state.copyWith(UsersFilter: action.UsersFilter);
//   // UsersReducer(_state, FilteredUsersModelAction());
//   return UsersReducer(_state, FilteredUsersModelAction());;
// }

UsersState _updateUsersFilterAction(
    UsersState state, UpdateUsersFilterAction action) {
  List<UserModel> filteredUserModel = [];
  print('_updateUsersFilterAction');
  if (state.usersFilter == UsersFilter.all) {
    filteredUserModel = state.allUserModel;
  }
  // else if (state.usersFilter == UsersFilter.checkTrue) {
  //   filteredUserModel = state.allUserModel
  //       .where((element) => element.check == true)
  //       .toList();
  // } else if (state.usersFilter == UsersFilter.checkFalse) {
  //   filteredUserModel = state.allUserModel
  //       .where((element) => element.check == false)
  //       .toList();
  // } else if (state.usersFilter == UsersFilter.checkNull) {
  //   filteredUserModel = state.allUserModel
  //       .where((element) => element.check == null)
  //       .toList();
  // }
  return state.copyWith(filteredUserModel: filteredUserModel);
}

// UsersState _addSelectedUserModelAction(
//     UsersState state, AddSelectedUserModelAction action) {
//   List<UserModel> selectedUserModelNew = state?.selectedUserModel ?? [];
//   if (state.allUserModel != null && state.allUserModel.isNotEmpty ) {
//     selectedUserModelNew.forEach((element) => print(element));
//     if (selectedUserModelNew.indexWhere((element) => element.id == action.id) <
//         0) {
//       selectedUserModelNew.add(
//           state.allUserModel.firstWhere((element) => element.id == action.id));
//     }
//   }
//   return state.copyWith(selectedUserModel: selectedUserModelNew);
// }

// UsersState _addSelectedUserModelAction(
//     UsersState state, AddSelectedUserModelAction action) {
//   print('_addSelectedUserModelAction...');
//   List<UserModel> selectedUserModelNew = state.selectedUserModel;
//   selectedUserModelNew.add(action.userModel);
//   return state.copyWith(selectedUserModel: selectedUserModelNew);
// }
