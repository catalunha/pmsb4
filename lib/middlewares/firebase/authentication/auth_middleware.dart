import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:pmsb4/states/enums.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseAuthenticationMiddleware() {
  return [
    TypedMiddleware<AppState, UserSendPasswordResetEmailAction>(_resetPassword()),
    TypedMiddleware<AppState, UserLoginEmailPasswordAction>(
        _loginEmailPassword()),
    TypedMiddleware<AppState, UserLoginGoogleAction>(_loginGoogle()),
    TypedMiddleware<AppState, UserLogoutAction>(_logout()),
  ];
}

Middleware<AppState> _resetPassword() {
  return (Store store, action, NextDispatcher next) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      store.dispatch(UserAuthenticationStatusAction(
          authenticationStatus: AuthenticationStatus.sendPasswordReset));
      firebaseAuth.sendPasswordResetEmail(email: action.email);
    } catch (e) {
      store.dispatch(UserLoginFailAction());
    }
    next(action);
  };
}

Middleware<AppState> _loginEmailPassword() {
  return (Store store, action, NextDispatcher next) async {
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
      print(firebaseUser.displayName);
      print(firebaseUser.email);
      print(firebaseUser.phoneNumber);
      print(firebaseUser.photoUrl);
      assert(!firebaseUser.isAnonymous);
      assert(await firebaseUser.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(firebaseUser.uid == currentUser.uid);
      store.dispatch(UserLoginSuccessfulAction(firebaseUser: firebaseUser));
      print('Login bem sucedido.');
    } catch (error) {
      store.dispatch(UserLoginFailAction(error: error));
      print('Login MAL sucedido.');
    }
    next(action);
  };
}

Middleware<AppState> _loginGoogle() {
  return (Store store, action, NextDispatcher next) async {
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
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      print('logout.');
      store.dispatch(UserLogoutSuccessfulAction());
    } catch (error) {
      print('_createLogoutMiddleware: $error');
    }
    next(action);
  };
}
