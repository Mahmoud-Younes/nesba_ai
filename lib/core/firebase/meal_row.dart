import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/// Typed shape of one meal document. UI rows are mapped from this type by the
/// shared mapper; no feature builds Firestore field strings itself.
class MealRow {
  const MealRow({
    required this.id,
    required this.name,
    required this.type,
    required this.kcal,
    required this.loggedAt,
    required this.dayKey,
    this.sync = 'ok',
    this.timeText = '',
  });

  final String id;
  final String name;
  final String type;
  final int kcal;
  final DateTime loggedAt;
  final String dayKey;
  final String sync;
  final String timeText;

  /// The day bucket is stored at write time in the user's local calendar.
  static String dayKeyFor(DateTime local) =>
      DateFormat('yyyy-MM-dd').format(local);

  /// Rolling seven-day window ending today, newest key first.
  static List<String> lastSevenDayKeys([DateTime? now]) {
    final DateTime today = now ?? DateTime.now();
    return List<String>.generate(
      7,
      (int index) => dayKeyFor(today.subtract(Duration(days: index))),
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'type': type,
        'kcal': kcal,
        'loggedAt': Timestamp.fromDate(loggedAt),
        'dayKey': dayKey,
        'syncStatus': sync,
      };

  factory MealRow.fromDoc(DocumentSnapshot<Object?> doc) {
    final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    final Timestamp stamp = data['loggedAt'] as Timestamp;
    final DateTime loggedAt = stamp.toDate();
    return MealRow(
      id: doc.id,
      name: data['name'] as String? ?? '',
      type: data['type'] as String? ?? 'breakfast',
      kcal: (data['kcal'] as num? ?? 0).round(),
      loggedAt: loggedAt,
      dayKey: data['dayKey'] as String? ?? dayKeyFor(loggedAt),
      sync: data['syncStatus'] as String? ?? 'ok',
      timeText: DateFormat('HH:mm').format(loggedAt),
    );
  }
}
