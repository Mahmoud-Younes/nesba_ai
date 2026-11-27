import 'package:nesba_ai/core/firebase/firestore_schema.dart';
import 'package:nesba_ai/core/firebase/restriction_category.dart';

enum ProfileSex { female, male }

enum ActivityLevel { sedentary, light, moderate, high }

enum BodyGoal { fatLoss, muscleGain, maintenance }

/// Read-only view of the signed-in user's profile. Unknown keys are ignored
/// and every field has a default so all four branches can read a partial doc.
class UserProfile {
  const UserProfile({
    this.weightKg,
    this.heightCm,
    this.age,
    this.sex,
    this.activity,
    this.bodyGoal,
    this.restrictions = const <RestrictionCategory>[],
    this.preferenceText = '',
    this.profileSkipped = false,
    this.schemaVersion = 0,
  });

  final double? weightKg;
  final double? heightCm;
  final int? age;
  final ProfileSex? sex;
  final ActivityLevel? activity;
  final BodyGoal? bodyGoal;
  final List<RestrictionCategory> restrictions;
  final String preferenceText;
  final bool profileSkipped;
  final int schemaVersion;

  Map<String, dynamic> toMap() => <String, dynamic>{
    FirestoreSchema.weightField: weightKg,
    FirestoreSchema.heightField: heightCm,
    FirestoreSchema.ageField: age,
    FirestoreSchema.sexField: sex?.name,
    FirestoreSchema.activityField: activity?.name,
    FirestoreSchema.bodyGoalField: bodyGoal?.name,
    FirestoreSchema.restrictionsField: restrictions
        .map((RestrictionCategory item) => item.wire)
        .toList(),
    FirestoreSchema.preferenceField: preferenceText,
    FirestoreSchema.profileSkippedField: profileSkipped,
    FirestoreSchema.schemaMarkerField: schemaVersion,
  };

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    final Object? weight = data[FirestoreSchema.weightField];
    final Object? height = data[FirestoreSchema.heightField];
    final Object? age = data[FirestoreSchema.ageField];
    final Object? rawRestrictions = data[FirestoreSchema.restrictionsField];
    return UserProfile(
      weightKg: weight is num ? weight.toDouble() : null,
      heightCm: height is num ? height.toDouble() : null,
      age: age is num ? age.round() : null,
      sex: _enumByName(ProfileSex.values, data[FirestoreSchema.sexField]),
      activity: _enumByName(
        ActivityLevel.values,
        data[FirestoreSchema.activityField],
      ),
      bodyGoal: _enumByName(
        BodyGoal.values,
        data[FirestoreSchema.bodyGoalField],
      ),
      restrictions: rawRestrictions is List
          ? rawRestrictions
                .map(
                  (Object? item) =>
                      RestrictionCategory.fromWire(item as String?),
                )
                .where((RestrictionCategory item) => item.isKnown)
                .toList()
          : const <RestrictionCategory>[],
      preferenceText: data[FirestoreSchema.preferenceField] as String? ?? '',
      profileSkipped:
          data[FirestoreSchema.profileSkippedField] as bool? ?? false,
      schemaVersion:
          (data[FirestoreSchema.schemaMarkerField] as num?)?.round() ?? 0,
    );
  }
}

T? _enumByName<T extends Enum>(List<T> values, Object? name) {
  if (name is! String) return null;
  for (final T value in values) {
    if (value.name == name) return value;
  }
  return null;
}
