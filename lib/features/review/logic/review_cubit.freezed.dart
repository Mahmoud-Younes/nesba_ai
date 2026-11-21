// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReviewState {

 ReviewMode get mode; bool get isLoading; bool get isFirstRun; List<Map<String, dynamic>> get meals; Map<String, dynamic>? get summary;/// Grams per macro for the day grid — null until the summary lands.
 ({int carbs, int fat, int protein,})? get macros;/// Set on load failure (states §1.5) — the screen shows the error card
/// with retry above whatever cache survived.
 String? get errorMessage;
/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewStateCopyWith<ReviewState> get copyWith => _$ReviewStateCopyWithImpl<ReviewState>(this as ReviewState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReviewState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewState&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.isFirstRun, _this.isFirstRun) || other.isFirstRun == _this.isFirstRun)&&const DeepCollectionEquality().equals(other.meals, _this.meals)&&const DeepCollectionEquality().equals(other.summary, _this.summary)&&(identical(other.macros, _this.macros) || other.macros == _this.macros)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as ReviewState;
  return Object.hash(runtimeType,_this.mode,_this.isLoading,_this.isFirstRun,const DeepCollectionEquality().hash(_this.meals),const DeepCollectionEquality().hash(_this.summary),_this.macros,_this.errorMessage);
}

@override
String toString() {
  final _this = this as ReviewState;
  return 'ReviewState(mode: ${_this.mode}, isLoading: ${_this.isLoading}, isFirstRun: ${_this.isFirstRun}, meals: ${_this.meals}, summary: ${_this.summary}, macros: ${_this.macros}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $ReviewStateCopyWith<$Res>  {
  factory $ReviewStateCopyWith(ReviewState value, $Res Function(ReviewState) _then) = _$ReviewStateCopyWithImpl;
@useResult
$Res call({
 ReviewMode mode, bool isLoading, bool isFirstRun, List<Map<String, dynamic>> meals, Map<String, dynamic>? summary, ({int carbs, int fat, int protein,})? macros, String? errorMessage
});




}
/// @nodoc
class _$ReviewStateCopyWithImpl<$Res>
    implements $ReviewStateCopyWith<$Res> {
  _$ReviewStateCopyWithImpl(this._self, this._then);

  final ReviewState _self;
  final $Res Function(ReviewState) _then;

/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? isLoading = null,Object? isFirstRun = null,Object? meals = null,Object? summary = freezed,Object? macros = freezed,Object? errorMessage = freezed,}) {
  return _then(ReviewState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ReviewMode,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFirstRun: null == isFirstRun ? _self.isFirstRun : isFirstRun // ignore: cast_nullable_to_non_nullable
as bool,meals: null == meals ? _self.meals : meals // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,macros: freezed == macros ? _self.macros : macros // ignore: cast_nullable_to_non_nullable
as ({int carbs, int fat, int protein,})?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewState].
extension ReviewStatePatterns on ReviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewState value)  $default,){
final _that = this;
switch (_that) {
case _ReviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewState value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReviewMode mode,  bool isLoading,  bool isFirstRun,  List<Map<String, dynamic>> meals,  Map<String, dynamic>? summary,  ({int carbs, int fat, int protein,})? macros,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewState() when $default != null:
return $default(_that.mode,_that.isLoading,_that.isFirstRun,_that.meals,_that.summary,_that.macros,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReviewMode mode,  bool isLoading,  bool isFirstRun,  List<Map<String, dynamic>> meals,  Map<String, dynamic>? summary,  ({int carbs, int fat, int protein,})? macros,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ReviewState():
return $default(_that.mode,_that.isLoading,_that.isFirstRun,_that.meals,_that.summary,_that.macros,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReviewMode mode,  bool isLoading,  bool isFirstRun,  List<Map<String, dynamic>> meals,  Map<String, dynamic>? summary,  ({int carbs, int fat, int protein,})? macros,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ReviewState() when $default != null:
return $default(_that.mode,_that.isLoading,_that.isFirstRun,_that.meals,_that.summary,_that.macros,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ReviewState implements ReviewState {
  const _ReviewState({this.mode = ReviewMode.day, this.isLoading = false, this.isFirstRun = false,  List<Map<String, dynamic>> meals = const <Map<String, dynamic>>[],  Map<String, dynamic>? summary, this.macros, this.errorMessage}): _meals = meals,_summary = summary;
  

@override@JsonKey() final  ReviewMode mode;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isFirstRun;
 final  List<Map<String, dynamic>> _meals;
@override@JsonKey() List<Map<String, dynamic>> get meals {
  if (_meals is EqualUnmodifiableListView) return _meals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meals);
}

 final  Map<String, dynamic>? _summary;
@override Map<String, dynamic>? get summary {
  final value = _summary;
  if (value == null) return null;
  if (_summary is EqualUnmodifiableMapView) return _summary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Grams per macro for the day grid — null until the summary lands.
@override final  ({int carbs, int fat, int protein,})? macros;
/// Set on load failure (states §1.5) — the screen shows the error card
/// with retry above whatever cache survived.
@override final  String? errorMessage;

/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewStateCopyWith<_ReviewState> get copyWith => __$ReviewStateCopyWithImpl<_ReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFirstRun, isFirstRun) || other.isFirstRun == isFirstRun)&&const DeepCollectionEquality().equals(other.meals, _meals)&&const DeepCollectionEquality().equals(other.summary, _summary)&&(identical(other.macros, macros) || other.macros == macros)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mode,isLoading,isFirstRun,const DeepCollectionEquality().hash(_meals),const DeepCollectionEquality().hash(_summary),macros,errorMessage);
}

@override
String toString() {
    return 'ReviewState(mode: $mode, isLoading: $isLoading, isFirstRun: $isFirstRun, meals: $meals, summary: $summary, macros: $macros, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ReviewStateCopyWith<$Res> implements $ReviewStateCopyWith<$Res> {
  factory _$ReviewStateCopyWith(_ReviewState value, $Res Function(_ReviewState) _then) = __$ReviewStateCopyWithImpl;
@override @useResult
$Res call({
 ReviewMode mode, bool isLoading, bool isFirstRun, List<Map<String, dynamic>> meals, Map<String, dynamic>? summary, ({int carbs, int fat, int protein,})? macros, String? errorMessage
});




}
/// @nodoc
class __$ReviewStateCopyWithImpl<$Res>
    implements _$ReviewStateCopyWith<$Res> {
  __$ReviewStateCopyWithImpl(this._self, this._then);

  final _ReviewState _self;
  final $Res Function(_ReviewState) _then;

/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? isLoading = null,Object? isFirstRun = null,Object? meals = null,Object? summary = freezed,Object? macros = freezed,Object? errorMessage = freezed,}) {
  return _then(_ReviewState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ReviewMode,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFirstRun: null == isFirstRun ? _self.isFirstRun : isFirstRun // ignore: cast_nullable_to_non_nullable
as bool,meals: null == meals ? _self._meals : meals // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,summary: freezed == summary ? _self._summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,macros: freezed == macros ? _self.macros : macros // ignore: cast_nullable_to_non_nullable
as ({int carbs, int fat, int protein,})?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
