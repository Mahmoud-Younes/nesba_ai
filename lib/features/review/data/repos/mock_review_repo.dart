import 'package:nesba_ai/features/review/data/repos/review_repo.dart';

/// Mock review data — 600ms latency keeps the first-read skeleton honest.
class MockReviewRepo implements ReviewRepo {
  static const Duration _latency = Duration(milliseconds: 600);

  @override
  Future<List<Map<String, dynamic>>> todayMeals() async {
    await Future.delayed(_latency);
    return <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'mock_review_101',
        'name': 'شوفان بالحليب والموز',
        'type': 'breakfast',
        'kcal': 380,
        'time': '07:40',
        'sync': 'ok',
        // Pre-baked group copy — the real list resolves day labels via
        // Intl (§2.6); the mock carries the string ready-made, no intl.
        'groupLabel': 'اليوم',
      },
      <String, dynamic>{
        'id': 'mock_review_102',
        'name': 'قهوة بالحليب',
        'type': 'snack',
        'kcal': 90,
        'time': '10:15',
        'sync': 'pending',
        'groupLabel': 'اليوم',
      },
      <String, dynamic>{
        'id': 'mock_review_103',
        'name': 'صدر دجاج مشوي مع أرز',
        'type': 'lunch',
        'kcal': 620,
        'time': '13:30',
        'sync': 'ok',
        'groupLabel': 'اليوم',
      },
      <String, dynamic>{
        'id': 'mock_review_104',
        'name': 'سلطة خضراء بالفيتا',
        'type': 'dinner',
        'kcal': 150,
        'time': '20:10',
        'sync': 'failed',
        'groupLabel': 'أمس',
      },
    ];
  }

  @override
  Future<Map<String, dynamic>> todaySummary() async {
    await Future.delayed(_latency);
    return <String, dynamic>{
      'consumed': 1240,
      'goal': 2000,
      // Macro grams (78/120/64) + daily targets so MacroGrid can render
      // «current / target» per macro (spec §2.6 example 78/120).
      'protein': 78,
      'carbs': 120,
      'fat': 64,
      'proteinGoal': 120,
      'carbsGoal': 260,
      'fatGoal': 70,
    };
  }
}
