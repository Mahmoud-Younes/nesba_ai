import 'package:nesba_ai/features/log/data/models/analysis_result.dart';
import 'package:nesba_ai/features/log/data/models/meal_item.dart';
import 'package:nesba_ai/features/log/data/repos/log_repo.dart';

class MockLogRepo implements LogRepo {
  @override
  Future<AnalysisResult> analyzeMeal(String description) async {
    await Future.delayed(const Duration(milliseconds: 2500));
    return const AnalysisResult(
      descriptionEcho: 'بيض وتوست وعصير برتقال',
      kcal: 430,
      verdict: VerdictLevel.acceptable,
      proteinGrams: 22,
      carbsGrams: 55,
      fatGrams: 13,
      items: [
        MealItem(
          name: 'بيض مسلوق',
          quantityMultiplier: 2,
          unit: MealUnit.piece,
          kcal: 156,
        ),
        MealItem(
          name: 'توست أسمر',
          quantityMultiplier: 2,
          unit: MealUnit.piece,
          kcal: 150,
          isLowConfidence: true,
        ),
        MealItem(
          name: 'عصير برتقال',
          quantityMultiplier: 1,
          grams: 248,
          unit: MealUnit.cup,
          kcal: 124,
        ),
      ],
      advice: 'الوجبة قريبة من المتوازن: البروتين جيد، وأغلب السعرات من الكارب في التوست والعصير.',
      verdictWhy: 'البروتين ≈ 22غ مقابل 55غ كاربوهيدرات والدهون ≈ 13غ فقط.',
    );
  }

  @override
  Future<String> saveMeal(AnalysisResult result) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return 'mock_meal_001';
  }

  @override
  Future<void> undoSave(String mealId) async {}

  @override
  Future<List<Map<String, dynamic>>> todayMeals() async {
    return [
      {'id': 'mock_meal_101', 'name': 'شوفان بالحليب والموز', 'kcal': 380, 'time': '07:40'},
      {'id': 'mock_meal_102', 'name': 'قهوة بالحليب', 'kcal': 90, 'time': '10:15'},
    ];
  }
}
