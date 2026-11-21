abstract class SwapRepo {
  /// Suggested original/alternative pairs — each row carries
  /// original_name/original_kcal/alt_name/alt_kcal/savings/hasFit
  /// (savings copy is pre-baked, deck §2.5).
  Future<List<Map<String, dynamic>>> swaps();
}
