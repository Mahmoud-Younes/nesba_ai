// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'swap_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SwapState {

 bool get isLoading; List<Map<String, dynamic>> get swaps; Set<String> get bookmarked;/// Non-null marker for any load failure — the screen renders the
/// err_server_* card while previous swaps stay visible (§2.8).
 String? get errorMsg;
/// Create a copy of SwapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwapStateCopyWith<SwapState> get copyWith => _$SwapStateCopyWithImpl<SwapState>(this as SwapState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SwapState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwapState&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&const DeepCollectionEquality().equals(other.swaps, _this.swaps)&&const DeepCollectionEquality().equals(other.bookmarked, _this.bookmarked)&&(identical(other.errorMsg, _this.errorMsg) || other.errorMsg == _this.errorMsg));
}


@override
int get hashCode {
  final _this = this as SwapState;
  return Object.hash(runtimeType,_this.isLoading,const DeepCollectionEquality().hash(_this.swaps),const DeepCollectionEquality().hash(_this.bookmarked),_this.errorMsg);
}

@override
String toString() {
  final _this = this as SwapState;
  return 'SwapState(isLoading: ${_this.isLoading}, swaps: ${_this.swaps}, bookmarked: ${_this.bookmarked}, errorMsg: ${_this.errorMsg})';
}


}

/// @nodoc
abstract mixin class $SwapStateCopyWith<$Res>  {
  factory $SwapStateCopyWith(SwapState value, $Res Function(SwapState) _then) = _$SwapStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<Map<String, dynamic>> swaps, Set<String> bookmarked, String? errorMsg
});




}
/// @nodoc
class _$SwapStateCopyWithImpl<$Res>
    implements $SwapStateCopyWith<$Res> {
  _$SwapStateCopyWithImpl(this._self, this._then);

  final SwapState _self;
  final $Res Function(SwapState) _then;

/// Create a copy of SwapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? swaps = null,Object? bookmarked = null,Object? errorMsg = freezed,}) {
  return _then(SwapState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,swaps: null == swaps ? _self.swaps : swaps // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as Set<String>,errorMsg: freezed == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SwapState].
extension SwapStatePatterns on SwapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SwapState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwapState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SwapState value)  $default,){
final _that = this;
switch (_that) {
case _SwapState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SwapState value)?  $default,){
final _that = this;
switch (_that) {
case _SwapState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<Map<String, dynamic>> swaps,  Set<String> bookmarked,  String? errorMsg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwapState() when $default != null:
return $default(_that.isLoading,_that.swaps,_that.bookmarked,_that.errorMsg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<Map<String, dynamic>> swaps,  Set<String> bookmarked,  String? errorMsg)  $default,) {final _that = this;
switch (_that) {
case _SwapState():
return $default(_that.isLoading,_that.swaps,_that.bookmarked,_that.errorMsg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<Map<String, dynamic>> swaps,  Set<String> bookmarked,  String? errorMsg)?  $default,) {final _that = this;
switch (_that) {
case _SwapState() when $default != null:
return $default(_that.isLoading,_that.swaps,_that.bookmarked,_that.errorMsg);case _:
  return null;

}
}

}

/// @nodoc


class _SwapState implements SwapState {
  const _SwapState({this.isLoading = false,  List<Map<String, dynamic>> swaps = const <Map<String, dynamic>>[],  Set<String> bookmarked = const <String>{}, this.errorMsg}): _swaps = swaps,_bookmarked = bookmarked;
  

@override@JsonKey() final  bool isLoading;
 final  List<Map<String, dynamic>> _swaps;
@override@JsonKey() List<Map<String, dynamic>> get swaps {
  if (_swaps is EqualUnmodifiableListView) return _swaps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_swaps);
}

 final  Set<String> _bookmarked;
@override@JsonKey() Set<String> get bookmarked {
  if (_bookmarked is EqualUnmodifiableSetView) return _bookmarked;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_bookmarked);
}

/// Non-null marker for any load failure — the screen renders the
/// err_server_* card while previous swaps stay visible (§2.8).
@override final  String? errorMsg;

/// Create a copy of SwapState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwapStateCopyWith<_SwapState> get copyWith => __$SwapStateCopyWithImpl<_SwapState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwapState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.swaps, _swaps)&&const DeepCollectionEquality().equals(other.bookmarked, _bookmarked)&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_swaps),const DeepCollectionEquality().hash(_bookmarked),errorMsg);
}

@override
String toString() {
    return 'SwapState(isLoading: $isLoading, swaps: $swaps, bookmarked: $bookmarked, errorMsg: $errorMsg)';
}


}

/// @nodoc
abstract mixin class _$SwapStateCopyWith<$Res> implements $SwapStateCopyWith<$Res> {
  factory _$SwapStateCopyWith(_SwapState value, $Res Function(_SwapState) _then) = __$SwapStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<Map<String, dynamic>> swaps, Set<String> bookmarked, String? errorMsg
});




}
/// @nodoc
class __$SwapStateCopyWithImpl<$Res>
    implements _$SwapStateCopyWith<$Res> {
  __$SwapStateCopyWithImpl(this._self, this._then);

  final _SwapState _self;
  final $Res Function(_SwapState) _then;

/// Create a copy of SwapState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? swaps = null,Object? bookmarked = null,Object? errorMsg = freezed,}) {
  return _then(_SwapState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,swaps: null == swaps ? _self._swaps : swaps // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,bookmarked: null == bookmarked ? _self._bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as Set<String>,errorMsg: freezed == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
