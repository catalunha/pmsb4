import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseAuthenticationMiddleware() {
  return [
    TypedMiddleware<AppState, UserSendPasswordResetEmailAction>(
        _resetPassword()),
    TypedMiddleware<AppState, UserUpdateProfileAction>(_updateprofile()),
    TypedMiddleware<AppState, UserLoginEmailPasswordAction>(
        _loginEmailPassword()),
    TypedMiddleware<AppState, UserLoginGoogleAction>(_loginGoogle()),
    TypedMiddleware<AppState, UserLogoutAction>(_logout()),
    TypedMiddleware<AppState, UserOnAuthStateChangedAction>(_logged()),
  ];
}

Middleware<AppState> _updateprofile() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    FirebaseUser firebaseUser = store.state.userState.firebaseUser;
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    userUpdateInfo.displayName = action.displayName;
    userUpdateInfo.photoUrl = action.photoUrl;
    print('_updateprofile1');
    await firebaseUser.updateProfile(userUpdateInfo).then((value) async {
      print('_updateprofile2');
      firebaseUser.reload();
      firebaseUser = await firebaseAuth.currentUser();
      store.dispatch(
          UserUpdateProfileSuccessfulAction(firebaseUser: firebaseUser));
      print('_updateprofile3');
    }).catchError((onError) => print('_updateprofile onError:' + onError));
  };
}

Middleware<AppState> _logged() {
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

Middleware<AppState> _resetPassword() {
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

Middleware<AppState> _loginEmailPassword() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser;

    try {
      print('Inciando autenticação...');
      store.dispatch(UserAuthenticationStatusAction(
          authenticationStatus: AuthenticationStatus.authenticating));
      print(action.email);
      print(action.password);
      final AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: action.email, password: action.password);
      // final AuthResult authResult = await _auth.signInWithEmailAndPassword(
      //     email: 'catalunha.mj@gmail.com', password: 'pmsbto22@ta');
      
      firebaseUser = authResult.user;
      print('firebaseUser:');
      print(firebaseUser.uid);
      print(firebaseUser.displayName);
      // print(firebaseUser.email);
      // print(firebaseUser.phoneNumber);
      // print(firebaseUser.photoUrl);
      // UserUpdateInfo info = UserUpdateInfo();
      // info.displayName = 'Prof. Catalunha';
      // info.photoUrl =
      //     'https://firebasestorage.googleapis.com/v0/b/pmsb-22-to.appspot.com/o/f99726f9-8988-4771-99bd-86cc6174c254?alt=media&token=3fc83c13-ef83-43e8-94a7-1a7068b403c9';
      // //https://firebasestorage.googleapis.com/v0/b/pmsb-22-to.appspot.com/o/77c6b7b8-087f-483b-8855-46f18d6b3ceb?alt=media&token=d0764f97-5ed0-4bcb-9da7-fcc1e3979945
      // //https://firebasestorage.googleapis.com/v0/b/pmsb-22-to.appspot.com/o/f99726f9-8988-4771-99bd-86cc6174c254?alt=media&token=3fc83c13-ef83-43e8-94a7-1a7068b403c9
      // await firebaseUser.updateProfile(info).then((value) => print('sucesso'));
      // firebaseUser.reload();
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

Middleware<AppState> _loginGoogle() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    FirebaseUser firebaseUser;
    print('ccc: _loginGoogle');
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

Middleware<AppState> _logout() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      print('logout.');
      store.dispatch(UserLogoutSuccessfulAction());
      next(action);
    } catch (error) {
      print('_createLogoutMiddleware: $error');
    }
  };
}
