import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nesba_ai/core/firebase/firestore_schema.dart';
import 'package:nesba_ai/core/firebase/goal_value.dart';

/// The only writer of `dailyGoalKcal` and its source. Both Person 1 and
/// Person 4 call this so the read-then-write is atomic.
Future<void> writeGoalValue({
  required String uid,
  required GoalValue goal,
}) async {
  final DocumentReference<Map<String, dynamic>> doc = FirebaseFirestore.instance
      .collection(FirestoreSchema.users)
      .doc(uid);
  await FirebaseFirestore.instance.runTransaction((Transaction tx) async {
    tx.set(doc, goal.toFirestore(), SetOptions(merge: true));
  });
}
