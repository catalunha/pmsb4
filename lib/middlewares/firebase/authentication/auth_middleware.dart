import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> firebaseAuthenticationMiddleware() {
  // final loginEmailPassword = _createLoginMiddleware();
  // final loginGoogle = _createLoginWithGoogleMiddleware();
  // final logout = _createLogoutMiddleware();

  return [
    TypedMiddleware<AppState, UserLoginEmailPassword>(_loginEmailPassword()),
    TypedMiddleware<AppState,UserLoginGoogle>(_loginGoogle()),
    TypedMiddleware<AppState, UserLogout>(_logout()),
  ];
}

Middleware<AppState> _loginEmailPassword() {
  return (Store store, action, NextDispatcher next) async {
    FirebaseUser user;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      print('Inciando autenticação...');
      print(action.email);
      print(action.password);
      final AuthResult authResult = await _auth.signInWithEmailAndPassword(email: action.email, password: action.password);
      // final AuthResult authResult = await _auth.signInWithEmailAndPassword(
      //     email: 'catalunha.mj@gmail.com', password: 'pmsbto22@ta');
      user = authResult.user;
      print('user:');
      print(user.displayName);
      print(user.email);
      print(user.phoneNumber);
      print(user.photoUrl);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      store.dispatch(UserLoginSuccessful(firebaseUser: user));
      next(action);
    } catch (error) {
      store.dispatch(UserLoginFail(error: error));
    }
  };
}

Middleware<AppState> _loginGoogle() {
  return (Store store, action, NextDispatcher next) async {
    FirebaseUser user;
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
      user = authResult.user;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      store.dispatch(UserLoginSuccessful(firebaseUser: user));

    } catch (error) {
      store.dispatch(UserLoginFail(error: error));
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
      store.dispatch(UserLogoutSuccessful());
      next(action);
    } catch (error) {
      print('_createLogoutMiddleware: $error');
    }
  };
}
