import 'package:nesba_ai/features/swaps/data/repos/swap_repo.dart';

/// Mock swaps data — 700ms latency keeps the pair-card skeleton honest.
class MockSwapRepo implements SwapRepo {
  static const Duration _latency = Duration(milliseconds: 700);

  @override
  Future<List<Map<String, dynamic>>> swaps() async {
    await Future.delayed(_latency);
    return <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'mock_swap_101',
        'original_name': 'شوفان بالحليب الكامل والموز',
        'original_kcal': 480,
        'alt_name': 'شوفان بحليب خالي الدسم والقرفة',
        'alt_kcal': 290,
        'savings': 320,
        'hasFit': true,
      },
      <String, dynamic>{
        'id': 'mock_swap_102',
        'original_name': 'صدر دجاج مقلي مع بطاطس',
        'original_kcal': 760,
        'alt_name': 'صدر دجاج مشوي مع بطاطس بالفرن',
        'alt_kcal': 470,
        'savings': 320,
        'hasFit': false,
      },
      <String, dynamic>{
        'id': 'mock_swap_103',
        'original_name': 'عصير برتقال محلّى',
        'original_kcal': 210,
        'alt_name': 'برتقالة كاملة',
        'alt_kcal': 90,
        'savings': 320,
        'hasFit': true,
      },
    ];
  }
}
