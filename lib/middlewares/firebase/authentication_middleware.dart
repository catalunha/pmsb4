import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pmsb4/actions/logged_action.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/types_states.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseAuthenticationMiddleware(
    FirebaseAuth firebaseAuthInstance) {
  return [
    TypedMiddleware<AppState, SendPasswordResetEmailLoggedAction>(
        _userSendPasswordResetEmailAction(firebaseAuthInstance)),
    TypedMiddleware<AppState, UpdateProfileDisplayNameLoggedAction>(
        _userUpdateProfileDisplayNameAction(firebaseAuthInstance)),
    TypedMiddleware<AppState, LoginEmailPasswordLoggedAction>(
        _userLoginEmailPasswordAction(firebaseAuthInstance)),
    TypedMiddleware<AppState, LoginGoogleLoggedAction>(
        _userLoginGoogleAction(firebaseAuthInstance)),
    TypedMiddleware<AppState, LogoutLoggedAction>(
        _userLogoutAction(firebaseAuthInstance)),
    TypedMiddleware<AppState, OnAuthStateChangedLoggedAction>(
        _onAuthStateChangedLoggedAction(firebaseAuthInstance)),
  ];
}

void Function(
  Store<AppState> store,
  UpdateProfileDisplayNameLoggedAction action,
  NextDispatcher next,
) _userUpdateProfileDisplayNameAction(FirebaseAuth firebaseAuthInstance) {
  return (store, action, next) async {
    //print('_userUpdateProfileDisplayNameAction...');
    final String _displayName = action.displayName;
    FirebaseUser firebaseUser = store.state.loggedState.firebaseUserLogged;

    if (_displayName != firebaseUser.displayName) {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = _displayName;
      // userUpdateInfo.photoUrl = photoUrl;
      await firebaseUser.updateProfile(userUpdateInfo).then((value) async {
        firebaseUser.reload();
        // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        firebaseUser = await firebaseAuthInstance.currentUser();
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
) _onAuthStateChangedLoggedAction(FirebaseAuth firebaseAuthInstance) {
  return (store, action, next) async {
    // print('_onAuthStateChangedLoggedAction...');
    // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // print('_onAuthStateChangedLoggedAction...1');
    try {
      // print('_onAuthStateChangedLoggedAction...2');
      firebaseAuthInstance.onAuthStateChanged.listen((firebaseUser) {
        // print('onAuthStateChanged: ${firebaseUser?.uid}');
        if (firebaseUser?.uid != null) {
          // print('_onAuthStateChangedLoggedAction...4');
          // print('Auth de ultimo login uid: ${firebaseUser.uid}');
          store.dispatch(
              LoginSuccessfulLoggedAction(firebaseUser: firebaseUser));
          // print('_onAuthStateChangedLoggedAction...5');
        } else {
          // print('_onAuthStateChangedLoggedAction...Logout');
        }
      });
      firebaseAuthInstance.currentUser().then((firebaseUser) {
        // print('_onAuthStateChangedLoggedAction...3');
        // print('currentUser: ${firebaseUser?.uid}');
        if (firebaseUser?.uid != null) {
          // print('_onAuthStateChangedLoggedAction...4');
          // print('Auth de ultimo login uid: ${firebaseUser.uid}');
          store.dispatch(
              LoginSuccessfulLoggedAction(firebaseUser: firebaseUser));
          // print('_onAuthStateChangedLoggedAction...5');
        }
        // print('_onAuthStateChangedLoggedAction...6');
      });
      //print('_onAuthStateChangedLoggedAction...7');
      // stream.listen((firebaseUser) {
      //   //print('ouvindo');
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
) _userSendPasswordResetEmailAction(FirebaseAuth firebaseAuthInstance) {
  return (store, action, next) async {
    //print('_userSendPasswordResetEmailAction...');
    try {
      store.dispatch(AuthenticationStatusLoggedAction(
          loggedAuthenticationStatus: AuthenticationStatus.sendPasswordReset));
      await firebaseAuthInstance.sendPasswordResetEmail(email: action.email);
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
) _userLoginEmailPasswordAction(FirebaseAuth firebaseAuthInstance) {
  return (store, action, next) async {
    //print('_userLoginEmailPasswordAction...');
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser;
    try {
      store.dispatch(AuthenticationStatusLoggedAction(
          loggedAuthenticationStatus: AuthenticationStatus.authenticating));
      print(action.email);
      print(action.password);
      await firebaseAuthInstance
          .signInWithEmailAndPassword(
              email: action.email, password: action.password)
          // ignore: missing_return
          .then((authResult2) async {
        firebaseUser = authResult2.user;
        assert(!firebaseUser.isAnonymous);
        assert(await firebaseUser.getIdToken() != null);
        final FirebaseUser currentUser =
            await firebaseAuthInstance.currentUser();
        assert(firebaseUser.uid == currentUser.uid);
        store.dispatch(LoginSuccessfulLoggedAction(firebaseUser: firebaseUser));
        //print('_userLoginEmailPasswordAction: Login bem sucedido.');
        next(action);
      });
    } catch (error) {
      store.dispatch(LoginFailLoggedAction(error: error));
      //print('_userLoginEmailPasswordAction: Login MAL sucedido. $error');
    }
  };
}

void Function(
  Store<AppState> store,
  LoginGoogleLoggedAction action,
  NextDispatcher next,
) _userLoginGoogleAction(FirebaseAuth firebaseAuthInstance) {
  return (store, action, next) async {
    //print('_userLoginGoogleAction...');
    FirebaseUser firebaseUser;
    // final FirebaseAuth _auth = FirebaseAuth.instance;
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
          await firebaseAuthInstance.signInWithCredential(credential);
      firebaseUser = authResult.user;
      assert(!firebaseUser.isAnonymous);
      assert(await firebaseUser.getIdToken() != null);
      final FirebaseUser currentUser = await firebaseAuthInstance.currentUser();
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
) _userLogoutAction(FirebaseAuth firebaseAuthInstance) {
  return (store, action, next) async {
    print('_userLogoutAction...');
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    print('_userLogoutAction...1');
    try {
      await firebaseAuthInstance.signOut().then((value) {
        print('_userLogoutAction...2');
        store.dispatch(LogoutSuccessfulLoggedAction());
        print('_userLogoutAction...3');
      });
      print('_userLogoutAction: Logout finalizado.');
      next(action);
    } catch (error) {
      print('_userLogoutAction: error: $error');
    }
  };
}
