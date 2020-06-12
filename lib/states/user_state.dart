import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
class UserState {
  final FirebaseUser firebaseUser;

  UserState({
    this.firebaseUser,
  });
  factory UserState.initial() {
    return UserState(firebaseUser: null);
  }
  UserState copyWith({FirebaseUser firebaseUser}) {
    return UserState(
      firebaseUser: firebaseUser,
    );
  }

  @override
  int get hashCode => firebaseUser.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          firebaseUser == other.firebaseUser;
}
