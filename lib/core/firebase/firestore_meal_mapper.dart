import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nesba_ai/core/firebase/meal_row.dart';

/// The single conversion between Firestore documents and app meal rows.
abstract final class FirestoreMealMapper {
  static Map<String, dynamic> toFirestore(MealRow row) => row.toMap();

  static MealRow fromFirestore(DocumentSnapshot<Object?> doc) =>
      MealRow.fromDoc(doc);

  static Map<String, dynamic> toUiRow(MealRow row) => <String, dynamic>{
        'id': row.id,
        'name': row.name,
        'type': row.type,
        'kcal': row.kcal,
        'time': row.timeText,
        'sync': row.sync,
        'groupKey': row.dayKey == MealRow.dayKeyFor(DateTime.now())
            ? 'today'
            : 'yesterday',
      };
}
