// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppState()';
}


}

/// @nodoc
class $AppStateCopyWith<$Res>  {
$AppStateCopyWith(AppState _, $Res Function(AppState) __);
}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _ThemeChangeMode value)?  themeChangeMode,TResult Function( _LanguageChange value)?  languageChange,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _ThemeChangeMode() when themeChangeMode != null:
return themeChangeMode(_that);case _LanguageChange() when languageChange != null:
return languageChange(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _ThemeChangeMode value)  themeChangeMode,required TResult Function( _LanguageChange value)  languageChange,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _ThemeChangeMode():
return themeChangeMode(_that);case _LanguageChange():
return languageChange(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _ThemeChangeMode value)?  themeChangeMode,TResult? Function( _LanguageChange value)?  languageChange,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _ThemeChangeMode() when themeChangeMode != null:
return themeChangeMode(_that);case _LanguageChange() when languageChange != null:
return languageChange(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( bool isDark)?  themeChangeMode,TResult Function( Locale locale)?  languageChange,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _ThemeChangeMode() when themeChangeMode != null:
return themeChangeMode(_that.isDark);case _LanguageChange() when languageChange != null:
return languageChange(_that.locale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( bool isDark)  themeChangeMode,required TResult Function( Locale locale)  languageChange,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _ThemeChangeMode():
return themeChangeMode(_that.isDark);case _LanguageChange():
return languageChange(_that.locale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( bool isDark)?  themeChangeMode,TResult? Function( Locale locale)?  languageChange,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _ThemeChangeMode() when themeChangeMode != null:
return themeChangeMode(_that.isDark);case _LanguageChange() when languageChange != null:
return languageChange(_that.locale);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AppState {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppState.initial()';
}


}




/// @nodoc


class _ThemeChangeMode implements AppState {
  const _ThemeChangeMode({required this.isDark});
  

 final  bool isDark;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeChangeModeCopyWith<_ThemeChangeMode> get copyWith => __$ThemeChangeModeCopyWithImpl<_ThemeChangeMode>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeChangeMode&&(identical(other.isDark, isDark) || other.isDark == isDark));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isDark);
}

@override
String toString() {
    return 'AppState.themeChangeMode(isDark: $isDark)';
}


}

/// @nodoc
abstract mixin class _$ThemeChangeModeCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$ThemeChangeModeCopyWith(_ThemeChangeMode value, $Res Function(_ThemeChangeMode) _then) = __$ThemeChangeModeCopyWithImpl;
@useResult
$Res call({
 bool isDark
});




}
/// @nodoc
class __$ThemeChangeModeCopyWithImpl<$Res>
    implements _$ThemeChangeModeCopyWith<$Res> {
  __$ThemeChangeModeCopyWithImpl(this._self, this._then);

  final _ThemeChangeMode _self;
  final $Res Function(_ThemeChangeMode) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isDark = null,}) {
  return _then(_ThemeChangeMode(
isDark: null == isDark ? _self.isDark : isDark // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _LanguageChange implements AppState {
  const _LanguageChange({required this.locale});
  

 final  Locale locale;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguageChangeCopyWith<_LanguageChange> get copyWith => __$LanguageChangeCopyWithImpl<_LanguageChange>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LanguageChange&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode {
    return Object.hash(runtimeType,locale);
}

@override
String toString() {
    return 'AppState.languageChange(locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$LanguageChangeCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$LanguageChangeCopyWith(_LanguageChange value, $Res Function(_LanguageChange) _then) = __$LanguageChangeCopyWithImpl;
@useResult
$Res call({
 Locale locale
});




}
/// @nodoc
class __$LanguageChangeCopyWithImpl<$Res>
    implements _$LanguageChangeCopyWith<$Res> {
  __$LanguageChangeCopyWithImpl(this._self, this._then);

  final _LanguageChange _self;
  final $Res Function(_LanguageChange) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? locale = null,}) {
  return _then(_LanguageChange(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}


}

// dart format on
