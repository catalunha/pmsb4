import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pmsb4/actions/user_action.dart';
import 'package:pmsb4/redux/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  final login = _createLoginMiddleware();
  // final login = _createLoginWithGoogleMiddleware();
  final logout = _createLogoutMiddleware();

  return [
    TypedMiddleware<AppState, UserLogin>(login),
    TypedMiddleware<AppState, UserLogout>(logout),
  ];
}

Middleware<AppState> _createLoginMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    FirebaseUser user;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      print('Inciando autenticação...');
      final AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: 'catalunha.mj@gmail.com', password: 'pmsbto22@ta');
      user = authResult.user;
      print('user:');
      print(user.uid);
      print(user.displayName);
      // assert(!user.isAnonymous);
      // assert(await user.getIdToken() != null);
      // final FirebaseUser currentUser = await _auth.currentUser();
      // assert(user.uid == currentUser.uid);
      store.dispatch(UserLoginSuccessful(firebaseUser: user));
      next(action);
    } catch (error) {
      store.dispatch(UserLoginFail(error: error));
    }
  };
}

Middleware<AppState> _createLoginWithGoogleMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    FirebaseUser user;
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
      // assert(!user.isAnonymous);
      // assert(await user.getIdToken() != null);
      // final FirebaseUser currentUser = await _auth.currentUser();
      // assert(user.uid == currentUser.uid);
      store.dispatch(UserLoginSuccessful(firebaseUser: user));

    } catch (error) {
      store.dispatch(UserLoginFail(error: error));
    }
    next(action);
  };
}

Middleware<AppState> _createLogoutMiddleware() {
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
