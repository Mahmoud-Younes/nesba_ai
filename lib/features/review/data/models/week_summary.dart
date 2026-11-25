/// One day in the weekly review; a null kcal means no data (not zero).
class WeekDay {
  const WeekDay({required this.date, this.kcal});

  final DateTime date;
  final int? kcal;

  bool get hasData => kcal != null;
}

/// Last seven days, oldest first, plus the week's macro grams.
class WeekSummary {
  const WeekSummary({
    required this.days,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
  });

  final List<WeekDay> days;
  final int proteinGrams;
  final int carbsGrams;
  final int fatGrams;

  bool get isEmpty => days.every((WeekDay day) => !day.hasData);
}
