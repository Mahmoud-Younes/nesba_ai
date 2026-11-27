/// One definition of every Firestore path and field name used by the app.
/// Feature code must not build these strings by hand.
abstract final class FirestoreSchema {
  static const String users = 'users';
  static const String meals = 'meals';
  static const String dailyGoalField = 'dailyGoalKcal';
  static const String goalSourceField = 'goalSource';
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

  static const String authProviderField = 'authProvider';
  static const String localeField = 'locale';
  static const String emailField = 'email';
  static const String displayNameField = 'displayName';

  static const String weightField = 'weightKg';
  static const String heightField = 'heightCm';
  static const String ageField = 'age';
  static const String sexField = 'sex';
  static const String activityField = 'activity';
  static const String bodyGoalField = 'bodyGoal';
  static const String restrictionsField = 'restrictions';
  static const String preferenceField = 'preferenceText';
  static const String profileSkippedField = 'profileSkipped';

  static const String alternativesField = 'alternatives';
  static const String containsField = 'contains';
  static const String proteinField = 'protein';

  static const String schemaMarkerField = 'schemaVersion';
  static const int schemaVersion = 1;
  static const String formulaVersionField = 'formulaVersion';
  static const String promptVersionField = 'promptVersion';
  static const String restrictionVersionField = 'restrictionVersion';

  static const String syncPending = 'pending';
  static const String syncOk = 'ok';
  static const String syncFailed = 'failed';
}
