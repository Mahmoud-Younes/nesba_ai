import 'package:nesba_ai/features/log/data/models/meal_item.dart';

enum VerdictLevel { balanced, acceptable, lighten }

class AnalysisResult {
  const AnalysisResult({
    required this.descriptionEcho,
    required this.kcal,
    required this.verdict,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    required this.items,
    required this.advice,
    required this.verdictWhy,
  });

  final String descriptionEcho;
  final int kcal;
  final VerdictLevel verdict;
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;
  final List<MealItem> items;
  final String advice;
  final String verdictWhy;

  AnalysisResult copyWith({
    String? descriptionEcho,
    int? kcal,
    VerdictLevel? verdict,
    double? proteinGrams,
    double? carbsGrams,
    double? fatGrams,
    List<MealItem>? items,
    String? advice,
    String? verdictWhy,
  }) {
    return AnalysisResult(
      descriptionEcho: descriptionEcho ?? this.descriptionEcho,
      kcal: kcal ?? this.kcal,
      verdict: verdict ?? this.verdict,
      proteinGrams: proteinGrams ?? this.proteinGrams,
      carbsGrams: carbsGrams ?? this.carbsGrams,
      fatGrams: fatGrams ?? this.fatGrams,
      items: items ?? this.items,
      advice: advice ?? this.advice,
      verdictWhy: verdictWhy ?? this.verdictWhy,
    );
  }
}
