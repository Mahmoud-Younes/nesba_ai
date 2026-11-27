import 'package:nesba_ai/core/service/shared_pref/pref_keys.dart';

/// The one uid-scoped goal cache key. Person 1 clears it at sign-out and
/// Person 4 reads it; neither imports a key from the other branch.
String goalCacheKey(String uid) => '${PrefKeys.dailyGoalKcal}:$uid';
