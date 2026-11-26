import 'package:firebase_auth/firebase_auth.dart';

/// Sign-in state exposed to the app shell. The unknown value exists for the
/// frame before Firebase restores a persisted session.
enum AuthStatus { unknown, signedIn, signedOut }

/// The only place that calls the Firebase Auth SDK. Feature code adds sign-in
/// strategies and repositories; it never talks to the SDK directly.
class AuthSession {
  AuthSession(this._auth);

  final FirebaseAuth _auth;

  Stream<AuthStatus> get status async* {
    yield AuthStatus.unknown;
    yield _auth.currentUser == null
        ? AuthStatus.signedOut
        : AuthStatus.signedIn;
    yield* _auth.authStateChanges().map(
          (user) => user == null ? AuthStatus.signedOut : AuthStatus.signedIn,
        );
  }

  String? get uid => _auth.currentUser?.uid;

  Future<String> signInWithCredential(AuthCredential credential) async {
    final UserCredential result = await _auth.signInWithCredential(credential);
    return result.user!.uid;
  }

  Future<void> signOut() => _auth.signOut();
}
