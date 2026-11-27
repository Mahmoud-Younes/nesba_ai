import 'package:nesba_ai/core/firebase/user_profile.dart';

/// Read-only profile access. The stream follows the signed-in user and closes
/// on sign-out; feature code never writes the profile through this interface.
abstract interface class ProfileRepository {
  Future<UserProfile?> read();

  Stream<UserProfile> watch();
}
