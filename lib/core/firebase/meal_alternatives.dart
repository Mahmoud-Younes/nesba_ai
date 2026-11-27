import 'package:nesba_ai/core/firebase/firestore_schema.dart';
import 'package:nesba_ai/core/firebase/restriction_category.dart';

/// One raw candidate as returned by Gemini. It is stored with the meal before
/// any filtering, so restriction edits and restarts do not lose alternatives.
class RawAlternative {
  const RawAlternative({
    required this.name,
    required this.type,
    required this.kcal,
    required this.contains,
    this.protein = 0,
  });

  final String name;
  final String type;
  final int kcal;
  final List<RestrictionCategory> contains;
  final int protein;

  Map<String, dynamic> toMap() => <String, dynamic>{
    FirestoreSchema.nameField: name,
    FirestoreSchema.typeField: type,
    FirestoreSchema.kcalField: kcal,
    FirestoreSchema.proteinField: protein,
    FirestoreSchema.containsField: contains
        .map((RestrictionCategory item) => item.wire)
        .toList(),
  };

  factory RawAlternative.fromMap(Map<String, dynamic> data) {
    final Object? raw = data[FirestoreSchema.containsField];
    return RawAlternative(
      name: data[FirestoreSchema.nameField] as String? ?? '',
      type: data[FirestoreSchema.typeField] as String? ?? 'breakfast',
      kcal: (data[FirestoreSchema.kcalField] as num?)?.round() ?? 0,
      protein: (data[FirestoreSchema.proteinField] as num?)?.round() ?? 0,
      contains: raw is List
          ? raw
                .map(
                  (Object? item) =>
                      RestrictionCategory.fromWire(item as String?),
                )
                .toList()
          : const <RestrictionCategory>[],
    );
  }
}
