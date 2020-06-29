import 'package:meta/meta.dart';
import 'package:pmsb4/models/user_model.dart';
import 'package:pmsb4/states/enums.dart';

@immutable
class UserState {
  final UserModel currentUserModel;
  final List<UserModel> allUserModel;
  final List<UserModel> filteredUserModel;
  final List<UserModel> selectedUserModel;
  final UsersFilter usersFilter;
  UserState(
      {this.allUserModel,
      this.currentUserModel,
      this.usersFilter,
      this.filteredUserModel,
      this.selectedUserModel});

  factory UserState.initial() {
    return UserState(
      currentUserModel: null,
      allUserModel: [],
      filteredUserModel: [],
      selectedUserModel: [],
      usersFilter: UsersFilter.all,
    );
  }
  UserState copyWith({
    UserModel currentUserModel,
    List<UserModel> allUserModel,
    List<UserModel> filteredUserModel,
    List<UserModel> selectedUserModel,
    UsersFilter usersFilter,
  }) {
    return UserState(
      currentUserModel: currentUserModel ?? this.currentUserModel,
      allUserModel: allUserModel ?? this.allUserModel,
      usersFilter: usersFilter ?? this.usersFilter,
      filteredUserModel: filteredUserModel ?? this.filteredUserModel,
      selectedUserModel: selectedUserModel ?? this.selectedUserModel,
    );
  }

  @override
  int get hashCode =>
      currentUserModel.hashCode ^
      allUserModel.hashCode ^
      usersFilter.hashCode ^
      filteredUserModel.hashCode ^
      selectedUserModel.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          currentUserModel == other.currentUserModel &&
          allUserModel == other.allUserModel &&
          usersFilter == other.usersFilter &&
          filteredUserModel == other.filteredUserModel &&
          selectedUserModel == other.selectedUserModel;

  @override
  String toString() {
    return 'UsersState{UserModel:$currentUserModel,allUserModel:$allUserModel,UsersFilter:$UsersFilter,filteredUserModel:$filteredUserModel}';
  }
}
