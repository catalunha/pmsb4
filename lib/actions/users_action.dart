import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/states/enums.dart';

class UsersAction {}

// +++ Actions atendidas pelo UsersReducer
class AllUsersModelAction extends UsersAction {
  final List<UserModel> allUserModel;

  AllUsersModelAction({this.allUserModel});
}

// class CurrentUserModelAction extends UsersAction {
//   final int index;
//   CurrentUserModelAction({this.index});
// }

class UpdateUsersFilterAction extends UsersAction {
  final UsersFilter usersFilter;

  UpdateUsersFilterAction({this.usersFilter});
}
class AddSelectedUserModelAction extends UsersAction {
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

class StreamUsersAction extends UsersAction {}

// class UpdateUsersAction extends UsersAction {
//   final UserModel UserModel;
//   UpdateUsersAction({this.UserModel});
// }

// class DeleteUsersAction extends UsersAction {
//   final String id;

//   DeleteUsersAction({this.id});
// }