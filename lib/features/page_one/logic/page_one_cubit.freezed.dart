// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_one_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PageOneState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PageOneState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PageOneState()';
}


}

/// @nodoc
class $PageOneStateCopyWith<$Res>  {
$PageOneStateCopyWith(PageOneState _, $Res Function(PageOneState) __);
}


/// Adds pattern-matching-related methods to [PageOneState].
extension PageOneStatePatterns on PageOneState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _CounterChanged value)?  counterChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _CounterChanged() when counterChanged != null:
return counterChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _CounterChanged value)  counterChanged,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _CounterChanged():
return counterChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _CounterChanged value)?  counterChanged,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _CounterChanged() when counterChanged != null:
return counterChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( int counter)?  counterChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _CounterChanged() when counterChanged != null:
return counterChanged(_that.counter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( int counter)  counterChanged,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _CounterChanged():
return counterChanged(_that.counter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( int counter)?  counterChanged,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _CounterChanged() when counterChanged != null:
return counterChanged(_that.counter);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PageOneState {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PageOneState.initial()';
}


}




/// @nodoc


class _CounterChanged implements PageOneState {
  const _CounterChanged({required this.counter});
  

 final  int counter;

/// Create a copy of PageOneState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CounterChangedCopyWith<_CounterChanged> get copyWith => __$CounterChangedCopyWithImpl<_CounterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CounterChanged&&(identical(other.counter, counter) || other.counter == counter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,counter);
}

@override
String toString() {
    return 'PageOneState.counterChanged(counter: $counter)';
}


}

/// @nodoc
abstract mixin class _$CounterChangedCopyWith<$Res> implements $PageOneStateCopyWith<$Res> {
  factory _$CounterChangedCopyWith(_CounterChanged value, $Res Function(_CounterChanged) _then) = __$CounterChangedCopyWithImpl;
@useResult
$Res call({
 int counter
});




}
/// @nodoc
class __$CounterChangedCopyWithImpl<$Res>
    implements _$CounterChangedCopyWith<$Res> {
  __$CounterChangedCopyWithImpl(this._self, this._then);

  final _CounterChanged _self;
  final $Res Function(_CounterChanged) _then;

/// Create a copy of PageOneState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? counter = null,}) {
  return _then(_CounterChanged(
counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
