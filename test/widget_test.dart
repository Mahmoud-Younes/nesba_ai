// Smoke test: language files parse and carry identical key sets.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lang/ar.json and lang/en.json parse with identical key sets', () {
    final Map<String, dynamic> ar =
        jsonDecode(File('lang/ar.json').readAsStringSync())
            as Map<String, dynamic>;
    final Map<String, dynamic> en =
        jsonDecode(File('lang/en.json').readAsStringSync())
            as Map<String, dynamic>;

    expect(ar.keys.toSet(), en.keys.toSet());
    expect(ar.values.every((v) => (v as String).isNotEmpty), isTrue);
    expect(en.values.every((v) => (v as String).isNotEmpty), isTrue);
  });
}
