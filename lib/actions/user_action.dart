import 'package:pmsb4/models/type_models.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/states/type_states.dart';

class UserAction {}

// +++ Actions atendidas pelo UsersReducer
class AllUserModelAction extends UserAction {
  final List<UserModel> allUserModel;

  AllUserModelAction({this.allUserModel});
}

// class CurrentUserModelAction extends UsersAction {
//   final int index;
//   CurrentUserModelAction({this.index});
// }

class UpdateUserFilterAction extends UserAction {
  final UsersFilter usersFilter;

  UpdateUserFilterAction({this.usersFilter});
}

class AddSelectedUserModelAction extends UserAction {
  final UserModel userModel;
  AddSelectedUserModelAction({this.userModel});
}

// class FilteredUsersModelAction extends UsersAction{

// }

// +++ Actions atendidas pelo firebaseFirestoreUsersMiddleware

// class AddUsersAction extends UsersAction {
//   final UserModel userModel;

//   AddUsersAction({this.userModel});
// }

class StreamUserDataAction extends UserAction {}

// class UpdateUsersAction extends UsersAction {
//   final UserModel UserModel;
//   UpdateUsersAction({this.UserModel});
// }

// class DeleteUsersAction extends UsersAction {
//   final String id;

//   DeleteUsersAction({this.id});
// }
