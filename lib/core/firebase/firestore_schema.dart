/// One definition of every Firestore path and field name used by the app.
/// Feature code must not build these strings by hand.
abstract final class FirestoreSchema {
  static const String users = 'users';
  static const String meals = 'meals';
  static const String dailyGoalField = 'dailyGoalKcal';
  static String userDoc(String uid) => '$users/$uid';
  static String mealDoc(String uid, String mealId) =>
      '$users/$uid/$meals/$mealId';
  static String mealsCollection(String uid) => '$users/$uid/$meals';

  static const String nameField = 'name';
  static const String typeField = 'type';
  static const String kcalField = 'kcal';
  static const String loggedAtField = 'loggedAt';
  static const String dayKeyField = 'dayKey';
  static const String syncField = 'syncStatus';
  static const String createdAtField = 'createdAt';

  static const String syncPending = 'pending';
  static const String syncOk = 'ok';
  static const String syncFailed = 'failed';
}
