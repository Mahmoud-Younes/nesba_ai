import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nesba_ai/core/firebase/firestore_schema.dart';
import 'package:nesba_ai/core/firebase/meal_alternatives.dart';

/// Typed shape of one meal document. UI rows are mapped from this type by the
/// shared mapper; no feature builds Firestore field strings itself.
class MealRow {
  const MealRow({
    required this.id,
    required this.name,
    required this.type,
    required this.kcal,
    required this.loggedAt,
    required this.dayKey,
    this.sync = 'ok',
    this.timeText = '',
    this.alternatives = const <RawAlternative>[],
  });

  final String id;
  final String name;
  final String type;
  final int kcal;
  final DateTime loggedAt;
  final String dayKey;
  final String sync;
  final String timeText;
  final List<RawAlternative> alternatives;

  /// The day bucket is stored at write time in the user's local calendar.
  static String dayKeyFor(DateTime local) =>
      DateFormat('yyyy-MM-dd').format(local);

  /// Rolling seven-day window ending today, newest key first.
  static List<String> lastSevenDayKeys([DateTime? now]) {
    final DateTime today = now ?? DateTime.now();
    return List<String>.generate(
      7,
      (int index) => dayKeyFor(today.subtract(Duration(days: index))),
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    FirestoreSchema.nameField: name,
    FirestoreSchema.typeField: type,
    FirestoreSchema.kcalField: kcal,
    FirestoreSchema.loggedAtField: Timestamp.fromDate(loggedAt),
    FirestoreSchema.dayKeyField: dayKey,
    FirestoreSchema.syncField: sync,
    FirestoreSchema.alternativesField: alternatives
        .map((RawAlternative item) => item.toMap())
        .toList(),
  };

  factory MealRow.fromDoc(DocumentSnapshot<Object?> doc) {
    final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    final Timestamp stamp = data[FirestoreSchema.loggedAtField] as Timestamp;
    final DateTime loggedAt = stamp.toDate();
    final Object? raw = data[FirestoreSchema.alternativesField];
    return MealRow(
      id: doc.id,
      name: data[FirestoreSchema.nameField] as String? ?? '',
      type: data[FirestoreSchema.typeField] as String? ?? 'breakfast',
      kcal: (data[FirestoreSchema.kcalField] as num? ?? 0).round(),
      loggedAt: loggedAt,
      dayKey:
          data[FirestoreSchema.dayKeyField] as String? ?? dayKeyFor(loggedAt),
      sync: data[FirestoreSchema.syncField] as String? ?? 'ok',
      timeText: DateFormat('HH:mm').format(loggedAt),
      alternatives: raw is List
          ? raw
                .map(
                  (Object? item) =>
                      RawAlternative.fromMap(item as Map<String, dynamic>),
                )
                .toList()
          : const <RawAlternative>[],
    );
  }
}
