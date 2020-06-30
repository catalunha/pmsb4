import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pmsb4/actions/logged_action.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/types_states.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseAuthenticationMiddleware() {
  return [
    TypedMiddleware<AppState, SendPasswordResetEmailLoggedAction>(
        _userSendPasswordResetEmailAction()),
    TypedMiddleware<AppState, UpdateProfileDisplayNameLoggedAction>(
        _userUpdateProfileDisplayNameAction()),
    TypedMiddleware<AppState, LoginEmailPasswordLoggedAction>(
        _userLoginEmailPasswordAction()),
    TypedMiddleware<AppState, LoginGoogleLoggedAction>(
        _userLoginGoogleAction()),
    TypedMiddleware<AppState, LogoutLoggedAction>(_userLogoutAction()),
    TypedMiddleware<AppState, OnAuthStateChangedLoggedAction>(
        _userOnAuthStateChangedAction()),
  ];
}

void Function(
  Store<AppState> store,
  UpdateProfileDisplayNameLoggedAction action,
  NextDispatcher next,
) _userUpdateProfileDisplayNameAction() {
  return (store, action, next) async {
    print('_userUpdateProfileDisplayNameAction...');
    final String _displayName = action.displayName;
    FirebaseUser firebaseUser = store.state.loggedState.firebaseUserLogged;

    if (_displayName != firebaseUser.displayName) {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = _displayName;
      await firebaseUser.updateProfile(userUpdateInfo).then((value) async {
        firebaseUser.reload();
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        firebaseUser = await firebaseAuth.currentUser();
        store.dispatch(
            UpdateProfileSuccessfulLoggedAction(firebaseUser: firebaseUser));
      }).catchError((onError) => print('_updateprofile onError:' + onError));
    }
    next(action);
  };
}

void Function(
  Store<AppState> store,
  OnAuthStateChangedLoggedAction action,
  NextDispatcher next,
) _userOnAuthStateChangedAction() {
  return (store, action, next) async {
    print('_userOnAuthStateChangedAction...');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      firebaseAuth.currentUser().then((firebaseUser) {
        if (firebaseUser?.uid != null) {
          print('Auth de ultimo login uid: ${firebaseUser.uid}');
          store.dispatch(
              LoginSuccessfulLoggedAction(firebaseUser: firebaseUser));
        }
      });
      // stream.listen((firebaseUser) {
      //   print('ouvindo');
      //   if (firebaseUser.isEmailVerified) {
      //     store.dispatch(UserAuthenticationStatusAction(
      //         authenticationStatus: AuthenticationStatus.authenticated));
      //     store.dispatch(UserLoginSuccessfulAction(firebaseUser: firebaseUser));
      //   }
      //  else {
      //   store.dispatch(UserAuthenticationStatusAction(
      //       authenticationStatus: AuthenticationStatus.unAuthenticated));
      // }
      // });
      next(action);
    } catch (error) {
      // store.dispatch(UserLoginFailAction(error: error));
    }
  };
}

void Function(
  Store<AppState> store,
  SendPasswordResetEmailLoggedAction action,
  NextDispatcher next,
) _userSendPasswordResetEmailAction() {
  return (store, action, next) async {
    print('_userSendPasswordResetEmailAction...');
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      store.dispatch(AuthenticationStatusLoggedAction(
          loggedAuthenticationStatus:
              LoggedAuthenticationStatus.sendPasswordReset));
      await firebaseAuth.sendPasswordResetEmail(email: action.email);
      next(action);
    } catch (e) {
      store.dispatch(LoginFailLoggedAction());
    }
  };
}

void Function(
  Store<AppState> store,
  LoginEmailPasswordLoggedAction action,
  NextDispatcher next,
) _userLoginEmailPasswordAction() {
  return (store, action, next) async {
    print('_userLoginEmailPasswordAction...');
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser;
    try {
      store.dispatch(AuthenticationStatusLoggedAction(
          loggedAuthenticationStatus:
              LoggedAuthenticationStatus.authenticating));
      print(action.email);
      print(action.password);
      final AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: action.email, password: action.password);
      firebaseUser = authResult.user;
      assert(!firebaseUser.isAnonymous);
      assert(await firebaseUser.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(firebaseUser.uid == currentUser.uid);
      store.dispatch(LoginSuccessfulLoggedAction(firebaseUser: firebaseUser));
      print('_userLoginEmailPasswordAction: Login bem sucedido.');
      next(action);
    } catch (error) {
      store.dispatch(LoginFailLoggedAction(error: error));
      print('_userLoginEmailPasswordAction: Login MAL sucedido. $error');
    }
  };
}

void Function(
  Store<AppState> store,
  LoginGoogleLoggedAction action,
  NextDispatcher next,
) _userLoginGoogleAction() {
  return (store, action, next) async {
    print('_userLoginGoogleAction...');
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
      store.dispatch(LoginSuccessfulLoggedAction(firebaseUser: firebaseUser));
    } catch (error) {
      store.dispatch(LoginFailLoggedAction(error: error));
    }
    next(action);
  };
}

void Function(
  Store<AppState> store,
  LogoutLoggedAction action,
  NextDispatcher next,
) _userLogoutAction() {
  return (store, action, next) async {
    print('_userLogoutAction...');
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      store.dispatch(LogoutSuccessfulLoggedAction());
      print('_userLogoutAction: Logout finalizado.');
      next(action);
    } catch (error) {
      print('_userLogoutAction: error: $error');
    }
  };
}
