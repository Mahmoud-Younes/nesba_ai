// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LogState {

 LogStatus get status; String get description; AnalysisResult? get result; int get progressStep; int get elapsedSeconds; bool get isStale; bool get isTimeout; bool get isSaving; bool get isDetailsExpanded; bool get showDisclaimer; String? get savedMealId; List<Map<String, dynamic>> get todayMeals; int get goalKcal; int get consumedKcal;
/// Create a copy of LogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogStateCopyWith<LogState> get copyWith => _$LogStateCopyWithImpl<LogState>(this as LogState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LogState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.result, _this.result) || other.result == _this.result)&&(identical(other.progressStep, _this.progressStep) || other.progressStep == _this.progressStep)&&(identical(other.elapsedSeconds, _this.elapsedSeconds) || other.elapsedSeconds == _this.elapsedSeconds)&&(identical(other.isStale, _this.isStale) || other.isStale == _this.isStale)&&(identical(other.isTimeout, _this.isTimeout) || other.isTimeout == _this.isTimeout)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.isDetailsExpanded, _this.isDetailsExpanded) || other.isDetailsExpanded == _this.isDetailsExpanded)&&(identical(other.showDisclaimer, _this.showDisclaimer) || other.showDisclaimer == _this.showDisclaimer)&&(identical(other.savedMealId, _this.savedMealId) || other.savedMealId == _this.savedMealId)&&const DeepCollectionEquality().equals(other.todayMeals, _this.todayMeals)&&(identical(other.goalKcal, _this.goalKcal) || other.goalKcal == _this.goalKcal)&&(identical(other.consumedKcal, _this.consumedKcal) || other.consumedKcal == _this.consumedKcal));
}


@override
int get hashCode {
  final _this = this as LogState;
  return Object.hash(runtimeType,_this.status,_this.description,_this.result,_this.progressStep,_this.elapsedSeconds,_this.isStale,_this.isTimeout,_this.isSaving,_this.isDetailsExpanded,_this.showDisclaimer,_this.savedMealId,const DeepCollectionEquality().hash(_this.todayMeals),_this.goalKcal,_this.consumedKcal);
}

@override
String toString() {
  final _this = this as LogState;
  return 'LogState(status: ${_this.status}, description: ${_this.description}, result: ${_this.result}, progressStep: ${_this.progressStep}, elapsedSeconds: ${_this.elapsedSeconds}, isStale: ${_this.isStale}, isTimeout: ${_this.isTimeout}, isSaving: ${_this.isSaving}, isDetailsExpanded: ${_this.isDetailsExpanded}, showDisclaimer: ${_this.showDisclaimer}, savedMealId: ${_this.savedMealId}, todayMeals: ${_this.todayMeals}, goalKcal: ${_this.goalKcal}, consumedKcal: ${_this.consumedKcal})';
}


}

/// @nodoc
abstract mixin class $LogStateCopyWith<$Res>  {
  factory $LogStateCopyWith(LogState value, $Res Function(LogState) _then) = _$LogStateCopyWithImpl;
@useResult
$Res call({
 LogStatus status, String description, AnalysisResult? result, int progressStep, int elapsedSeconds, bool isStale, bool isTimeout, bool isSaving, bool isDetailsExpanded, bool showDisclaimer, String? savedMealId, List<Map<String, dynamic>> todayMeals, int goalKcal, int consumedKcal
});




}
/// @nodoc
class _$LogStateCopyWithImpl<$Res>
    implements $LogStateCopyWith<$Res> {
  _$LogStateCopyWithImpl(this._self, this._then);

  final LogState _self;
  final $Res Function(LogState) _then;

/// Create a copy of LogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? description = null,Object? result = freezed,Object? progressStep = null,Object? elapsedSeconds = null,Object? isStale = null,Object? isTimeout = null,Object? isSaving = null,Object? isDetailsExpanded = null,Object? showDisclaimer = null,Object? savedMealId = freezed,Object? todayMeals = null,Object? goalKcal = null,Object? consumedKcal = null,}) {
  return _then(LogState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LogStatus,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as AnalysisResult?,progressStep: null == progressStep ? _self.progressStep : progressStep // ignore: cast_nullable_to_non_nullable
as int,elapsedSeconds: null == elapsedSeconds ? _self.elapsedSeconds : elapsedSeconds // ignore: cast_nullable_to_non_nullable
as int,isStale: null == isStale ? _self.isStale : isStale // ignore: cast_nullable_to_non_nullable
as bool,isTimeout: null == isTimeout ? _self.isTimeout : isTimeout // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isDetailsExpanded: null == isDetailsExpanded ? _self.isDetailsExpanded : isDetailsExpanded // ignore: cast_nullable_to_non_nullable
as bool,showDisclaimer: null == showDisclaimer ? _self.showDisclaimer : showDisclaimer // ignore: cast_nullable_to_non_nullable
as bool,savedMealId: freezed == savedMealId ? _self.savedMealId : savedMealId // ignore: cast_nullable_to_non_nullable
as String?,todayMeals: null == todayMeals ? _self.todayMeals : todayMeals // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,goalKcal: null == goalKcal ? _self.goalKcal : goalKcal // ignore: cast_nullable_to_non_nullable
as int,consumedKcal: null == consumedKcal ? _self.consumedKcal : consumedKcal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LogState].
extension LogStatePatterns on LogState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LogState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LogState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LogState value)  $default,){
final _that = this;
switch (_that) {
case _LogState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LogState value)?  $default,){
final _that = this;
switch (_that) {
case _LogState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LogStatus status,  String description,  AnalysisResult? result,  int progressStep,  int elapsedSeconds,  bool isStale,  bool isTimeout,  bool isSaving,  bool isDetailsExpanded,  bool showDisclaimer,  String? savedMealId,  List<Map<String, dynamic>> todayMeals,  int goalKcal,  int consumedKcal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LogState() when $default != null:
return $default(_that.status,_that.description,_that.result,_that.progressStep,_that.elapsedSeconds,_that.isStale,_that.isTimeout,_that.isSaving,_that.isDetailsExpanded,_that.showDisclaimer,_that.savedMealId,_that.todayMeals,_that.goalKcal,_that.consumedKcal);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LogStatus status,  String description,  AnalysisResult? result,  int progressStep,  int elapsedSeconds,  bool isStale,  bool isTimeout,  bool isSaving,  bool isDetailsExpanded,  bool showDisclaimer,  String? savedMealId,  List<Map<String, dynamic>> todayMeals,  int goalKcal,  int consumedKcal)  $default,) {final _that = this;
switch (_that) {
case _LogState():
return $default(_that.status,_that.description,_that.result,_that.progressStep,_that.elapsedSeconds,_that.isStale,_that.isTimeout,_that.isSaving,_that.isDetailsExpanded,_that.showDisclaimer,_that.savedMealId,_that.todayMeals,_that.goalKcal,_that.consumedKcal);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LogStatus status,  String description,  AnalysisResult? result,  int progressStep,  int elapsedSeconds,  bool isStale,  bool isTimeout,  bool isSaving,  bool isDetailsExpanded,  bool showDisclaimer,  String? savedMealId,  List<Map<String, dynamic>> todayMeals,  int goalKcal,  int consumedKcal)?  $default,) {final _that = this;
switch (_that) {
case _LogState() when $default != null:
return $default(_that.status,_that.description,_that.result,_that.progressStep,_that.elapsedSeconds,_that.isStale,_that.isTimeout,_that.isSaving,_that.isDetailsExpanded,_that.showDisclaimer,_that.savedMealId,_that.todayMeals,_that.goalKcal,_that.consumedKcal);case _:
  return null;

}
}

}

/// @nodoc


class _LogState implements LogState {
  const _LogState({this.status = LogStatus.draft, this.description = '', this.result, this.progressStep = 1, this.elapsedSeconds = 0, this.isStale = false, this.isTimeout = false, this.isSaving = false, this.isDetailsExpanded = false, this.showDisclaimer = false, this.savedMealId,  List<Map<String, dynamic>> todayMeals = const <Map<String, dynamic>>[], this.goalKcal = 0, this.consumedKcal = 0}): _todayMeals = todayMeals;
  

@override@JsonKey() final  LogStatus status;
@override@JsonKey() final  String description;
@override final  AnalysisResult? result;
@override@JsonKey() final  int progressStep;
@override@JsonKey() final  int elapsedSeconds;
@override@JsonKey() final  bool isStale;
@override@JsonKey() final  bool isTimeout;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isDetailsExpanded;
@override@JsonKey() final  bool showDisclaimer;
@override final  String? savedMealId;
 final  List<Map<String, dynamic>> _todayMeals;
@override@JsonKey() List<Map<String, dynamic>> get todayMeals {
  if (_todayMeals is EqualUnmodifiableListView) return _todayMeals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todayMeals);
}

@override@JsonKey() final  int goalKcal;
@override@JsonKey() final  int consumedKcal;

/// Create a copy of LogState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogStateCopyWith<_LogState> get copyWith => __$LogStateCopyWithImpl<_LogState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogState&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.result, result) || other.result == result)&&(identical(other.progressStep, progressStep) || other.progressStep == progressStep)&&(identical(other.elapsedSeconds, elapsedSeconds) || other.elapsedSeconds == elapsedSeconds)&&(identical(other.isStale, isStale) || other.isStale == isStale)&&(identical(other.isTimeout, isTimeout) || other.isTimeout == isTimeout)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isDetailsExpanded, isDetailsExpanded) || other.isDetailsExpanded == isDetailsExpanded)&&(identical(other.showDisclaimer, showDisclaimer) || other.showDisclaimer == showDisclaimer)&&(identical(other.savedMealId, savedMealId) || other.savedMealId == savedMealId)&&const DeepCollectionEquality().equals(other.todayMeals, _todayMeals)&&(identical(other.goalKcal, goalKcal) || other.goalKcal == goalKcal)&&(identical(other.consumedKcal, consumedKcal) || other.consumedKcal == consumedKcal));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,description,result,progressStep,elapsedSeconds,isStale,isTimeout,isSaving,isDetailsExpanded,showDisclaimer,savedMealId,const DeepCollectionEquality().hash(_todayMeals),goalKcal,consumedKcal);
}

@override
String toString() {
    return 'LogState(status: $status, description: $description, result: $result, progressStep: $progressStep, elapsedSeconds: $elapsedSeconds, isStale: $isStale, isTimeout: $isTimeout, isSaving: $isSaving, isDetailsExpanded: $isDetailsExpanded, showDisclaimer: $showDisclaimer, savedMealId: $savedMealId, todayMeals: $todayMeals, goalKcal: $goalKcal, consumedKcal: $consumedKcal)';
}


}

/// @nodoc
abstract mixin class _$LogStateCopyWith<$Res> implements $LogStateCopyWith<$Res> {
  factory _$LogStateCopyWith(_LogState value, $Res Function(_LogState) _then) = __$LogStateCopyWithImpl;
@override @useResult
$Res call({
 LogStatus status, String description, AnalysisResult? result, int progressStep, int elapsedSeconds, bool isStale, bool isTimeout, bool isSaving, bool isDetailsExpanded, bool showDisclaimer, String? savedMealId, List<Map<String, dynamic>> todayMeals, int goalKcal, int consumedKcal
});




}
/// @nodoc
class __$LogStateCopyWithImpl<$Res>
    implements _$LogStateCopyWith<$Res> {
  __$LogStateCopyWithImpl(this._self, this._then);

  final _LogState _self;
  final $Res Function(_LogState) _then;

/// Create a copy of LogState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? description = null,Object? result = freezed,Object? progressStep = null,Object? elapsedSeconds = null,Object? isStale = null,Object? isTimeout = null,Object? isSaving = null,Object? isDetailsExpanded = null,Object? showDisclaimer = null,Object? savedMealId = freezed,Object? todayMeals = null,Object? goalKcal = null,Object? consumedKcal = null,}) {
  return _then(_LogState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LogStatus,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as AnalysisResult?,progressStep: null == progressStep ? _self.progressStep : progressStep // ignore: cast_nullable_to_non_nullable
as int,elapsedSeconds: null == elapsedSeconds ? _self.elapsedSeconds : elapsedSeconds // ignore: cast_nullable_to_non_nullable
as int,isStale: null == isStale ? _self.isStale : isStale // ignore: cast_nullable_to_non_nullable
as bool,isTimeout: null == isTimeout ? _self.isTimeout : isTimeout // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isDetailsExpanded: null == isDetailsExpanded ? _self.isDetailsExpanded : isDetailsExpanded // ignore: cast_nullable_to_non_nullable
as bool,showDisclaimer: null == showDisclaimer ? _self.showDisclaimer : showDisclaimer // ignore: cast_nullable_to_non_nullable
as bool,savedMealId: freezed == savedMealId ? _self.savedMealId : savedMealId // ignore: cast_nullable_to_non_nullable
as String?,todayMeals: null == todayMeals ? _self._todayMeals : todayMeals // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,goalKcal: null == goalKcal ? _self.goalKcal : goalKcal // ignore: cast_nullable_to_non_nullable
as int,consumedKcal: null == consumedKcal ? _self.consumedKcal : consumedKcal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
