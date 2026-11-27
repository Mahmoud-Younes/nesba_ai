import 'package:nesba_ai/core/firebase/firestore_schema.dart';

/// Where the daily goal number came from. A goal with no source is unset.
enum GoalSource { calculated, manual }

/// One nullable goal value and its source.
class GoalValue {
  const GoalValue({this.kcal, this.source});

  final int? kcal;
  final GoalSource? source;

  bool get isUnset => kcal == null || kcal! <= 0 || source == null;

  Map<String, dynamic> toFirestore() => <String, dynamic>{
    FirestoreSchema.dailyGoalField: kcal,
    FirestoreSchema.goalSourceField: source?.name,
  };

  factory GoalValue.fromMap(Map<String, dynamic> data) {
    final Object? raw = data[FirestoreSchema.dailyGoalField];
    final String? sourceName = data[FirestoreSchema.goalSourceField] as String?;
    return GoalValue(
      kcal: raw is num ? raw.round() : null,
      source: sourceName == null
          ? null
          : GoalSource.values.firstWhere(
              (GoalSource value) => value.name == sourceName,
              orElse: () => GoalSource.manual,
            ),
    );
  }
}
