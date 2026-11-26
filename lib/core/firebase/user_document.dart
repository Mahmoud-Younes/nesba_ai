import 'package:cloud_firestore/cloud_firestore.dart';

/// Creates the user document once and never overwrites existing values.
/// Called after a successful sign-in by the authentication track.
Future<void> ensureUserDoc({
  required String uid,
  required String authProvider,
  required String locale,
  String? email,
  String? displayName,
}) async {
  final DocumentReference<Map<String, dynamic>> doc =
      FirebaseFirestore.instance.collection('users').doc(uid);
  final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
  if (snapshot.exists) return;
  await doc.set(<String, dynamic>{
    'authProvider': authProvider,
    'locale': locale,
    'email': email,
    'displayName': displayName,
    'createdAt': FieldValue.serverTimestamp(),
    'dailyGoalKcal': 0,
  });
}
