import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nesba_ai/core/firebase/firestore_schema.dart';

/// Creates the user document once and backfills missing fields for an
/// upgraded user. Existing values are never overwritten.
Future<void> ensureUserDoc({
  required String uid,
  required String authProvider,
  required String locale,
  String? email,
  String? displayName,
}) async {
  final DocumentReference<Map<String, dynamic>> doc = FirebaseFirestore.instance
      .collection(FirestoreSchema.users)
      .doc(uid);
  final DocumentSnapshot<Map<String, dynamic>> snapshot = await doc.get();
  final Map<String, dynamic> existing = snapshot.data() ?? <String, dynamic>{};

  final Map<String, dynamic> defaults = <String, dynamic>{
    FirestoreSchema.authProviderField: authProvider,
    FirestoreSchema.localeField: locale,
    FirestoreSchema.emailField: email,
    FirestoreSchema.displayNameField: displayName,
    FirestoreSchema.createdAtField: FieldValue.serverTimestamp(),
    FirestoreSchema.schemaMarkerField: FirestoreSchema.schemaVersion,
  };

  final Map<String, dynamic> patch = <String, dynamic>{};
  defaults.forEach((String key, dynamic value) {
    if (!existing.containsKey(key)) patch[key] = value;
  });
  if (patch.isEmpty) return;

  await doc.set(patch, SetOptions(merge: true));
}
