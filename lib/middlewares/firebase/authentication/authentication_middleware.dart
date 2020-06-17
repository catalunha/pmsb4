import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseAuthenticationMiddleware() {
  return [
    TypedMiddleware<AppState, UserSendPasswordResetEmailAction>(
        _userSendPasswordResetEmailAction()),
    TypedMiddleware<AppState, UserUpdateProfileDisplayNameAction>(
        _userUpdateProfileDisplayNameAction()),
    TypedMiddleware<AppState, UserLoginEmailPasswordAction>(
        _userLoginEmailPasswordAction()),
    TypedMiddleware<AppState, UserLoginGoogleAction>(_userLoginGoogleAction()),
    TypedMiddleware<AppState, UserLogoutAction>(_userLogoutAction()),
    TypedMiddleware<AppState, UserOnAuthStateChangedAction>(
        _userOnAuthStateChangedAction()),
  ];
}

Middleware<AppState> _userUpdateProfileDisplayNameAction() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    final String _displayName = action.displayName;
    FirebaseUser firebaseUser = store.state.userState.firebaseUser;

    if (_displayName != firebaseUser.displayName) {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = _displayName;
      await firebaseUser.updateProfile(userUpdateInfo).then((value) async {
        firebaseUser.reload();
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        firebaseUser = await firebaseAuth.currentUser();
        store.dispatch(
            UserUpdateProfileSuccessfulAction(firebaseUser: firebaseUser));
      }).catchError((onError) => print('_updateprofile onError:' + onError));
    }
    next(action);
  };
}

Middleware<AppState> _userOnAuthStateChangedAction() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // final FirebaseAuth firebaseAuth;
    try {
      print('_logged1');
      // firebaseAuth.onAuthStateChanged((firebaseUser) async {
      //   print('_logged2');
      //   if (firebaseUser != null) {
      //     print('_logged3');
      //     // assert(!firebaseUser.isAnonymous);
      //     // assert(await firebaseUser.getIdToken() != null);
      //     // final FirebaseUser currentUser = await firebaseAuth.currentUser();
      //     // assert(firebaseUser.uid == currentUser.uid);
      //     store.dispatch(UserAuthenticationStatusAction(
      //         authenticationStatus: AuthenticationStatus.authenticated));
      //     store.dispatch(UserLoginSuccessfulAction(firebaseUser: firebaseUser));
      //   } else {
      //     store.dispatch(UserLogoutAction());
      //     store.dispatch(UserAuthenticationStatusAction(
      //         authenticationStatus: AuthenticationStatus.unAuthenticated));
      //   }
      // }));
      next(action);
    } catch (error) {
      // store.dispatch(UserLoginFailAction(error: error));
    }
  };
}

Middleware<AppState> _userSendPasswordResetEmailAction() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      store.dispatch(UserAuthenticationStatusAction(
          authenticationStatus: AuthenticationStatus.sendPasswordReset));
      await firebaseAuth.sendPasswordResetEmail(email: action.email);
      next(action);
    } catch (e) {
      store.dispatch(UserLoginFailAction());
    }
  };
}

Middleware<AppState> _userLoginEmailPasswordAction() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser;
    try {
      store.dispatch(UserAuthenticationStatusAction(
          authenticationStatus: AuthenticationStatus.authenticating));
      print(action.email);
      print(action.password);
      final AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: action.email, password: action.password);
      firebaseUser = authResult.user;
      assert(!firebaseUser.isAnonymous);
      assert(await firebaseUser.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(firebaseUser.uid == currentUser.uid);
      store.dispatch(UserLoginSuccessfulAction(firebaseUser: firebaseUser));
      print('Login bem sucedido.');
      next(action);
    } catch (error) {
      store.dispatch(UserLoginFailAction(error: error));
      print('Login MAL sucedido. $error');
    }
  };
}

Middleware<AppState> _userLoginGoogleAction() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    FirebaseUser firebaseUser;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      firebaseUser = authResult.user;
      assert(!firebaseUser.isAnonymous);
      assert(await firebaseUser.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(firebaseUser.uid == currentUser.uid);
      store.dispatch(UserLoginSuccessfulAction(firebaseUser: firebaseUser));
    } catch (error) {
      store.dispatch(UserLoginFailAction(error: error));
    }
    next(action);
  };
}

Middleware<AppState> _userLogoutAction() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      print('logout.');
      store.dispatch(UserLogoutSuccessfulAction());
      next(action);
    } catch (error) {
      print('_userLogoutAction error: $error');
    }
  };
}