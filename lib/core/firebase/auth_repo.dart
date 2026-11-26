abstract interface class AuthRepo {
  Future<String> signInWithEmail(String email, String password);
  Future<String> signInWithGoogle();
  Future<void> signOut();
}
