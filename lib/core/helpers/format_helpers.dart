/// Western digits with thousands groups («1,240») — no intl dependency.
String formatCalories(int value) {
  final String digits = value.abs().toString();
  final StringBuffer grouped = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    grouped.write(digits[i]);
    final int remaining = digits.length - i;
    if (remaining > 1 && remaining % 3 == 1) {
      grouped.write(',');
    }
  }
  return value < 0 ? '-$grouped' : grouped.toString();
}
