// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_two_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PageTwoState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PageTwoState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PageTwoState()';
}


}

/// @nodoc
class $PageTwoStateCopyWith<$Res>  {
$PageTwoStateCopyWith(PageTwoState _, $Res Function(PageTwoState) __);
}


/// Adds pattern-matching-related methods to [PageTwoState].
extension PageTwoStatePatterns on PageTwoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _ColorChanged value)?  colorChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _ColorChanged() when colorChanged != null:
return colorChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _ColorChanged value)  colorChanged,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _ColorChanged():
return colorChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _ColorChanged value)?  colorChanged,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _ColorChanged() when colorChanged != null:
return colorChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( int colorIndex)?  colorChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _ColorChanged() when colorChanged != null:
return colorChanged(_that.colorIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( int colorIndex)  colorChanged,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _ColorChanged():
return colorChanged(_that.colorIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( int colorIndex)?  colorChanged,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _ColorChanged() when colorChanged != null:
return colorChanged(_that.colorIndex);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PageTwoState {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PageTwoState.initial()';
}


}




/// @nodoc


class _ColorChanged implements PageTwoState {
  const _ColorChanged({required this.colorIndex});
  

 final  int colorIndex;

/// Create a copy of PageTwoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ColorChangedCopyWith<_ColorChanged> get copyWith => __$ColorChangedCopyWithImpl<_ColorChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ColorChanged&&(identical(other.colorIndex, colorIndex) || other.colorIndex == colorIndex));
}


@override
int get hashCode {
    return Object.hash(runtimeType,colorIndex);
}

@override
String toString() {
    return 'PageTwoState.colorChanged(colorIndex: $colorIndex)';
}


}

/// @nodoc
abstract mixin class _$ColorChangedCopyWith<$Res> implements $PageTwoStateCopyWith<$Res> {
  factory _$ColorChangedCopyWith(_ColorChanged value, $Res Function(_ColorChanged) _then) = __$ColorChangedCopyWithImpl;
@useResult
$Res call({
 int colorIndex
});




}
/// @nodoc
class __$ColorChangedCopyWithImpl<$Res>
    implements _$ColorChangedCopyWith<$Res> {
  __$ColorChangedCopyWithImpl(this._self, this._then);

  final _ColorChanged _self;
  final $Res Function(_ColorChanged) _then;

/// Create a copy of PageTwoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? colorIndex = null,}) {
  return _then(_ColorChanged(
colorIndex: null == colorIndex ? _self.colorIndex : colorIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
