// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_logs_filter_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionLogsFilterState {

 bool get showGrouped; bool get blockedOnly; bool get allowedOnly; String get filterApplication; LogSorting get sorting;
/// Create a copy of SessionLogsFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionLogsFilterStateCopyWith<SessionLogsFilterState> get copyWith => _$SessionLogsFilterStateCopyWithImpl<SessionLogsFilterState>(this as SessionLogsFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionLogsFilterState&&(identical(other.showGrouped, showGrouped) || other.showGrouped == showGrouped)&&(identical(other.blockedOnly, blockedOnly) || other.blockedOnly == blockedOnly)&&(identical(other.allowedOnly, allowedOnly) || other.allowedOnly == allowedOnly)&&(identical(other.filterApplication, filterApplication) || other.filterApplication == filterApplication)&&(identical(other.sorting, sorting) || other.sorting == sorting));
}


@override
int get hashCode => Object.hash(runtimeType,showGrouped,blockedOnly,allowedOnly,filterApplication,sorting);

@override
String toString() {
  return 'SessionLogsFilterState(showGrouped: $showGrouped, blockedOnly: $blockedOnly, allowedOnly: $allowedOnly, filterApplication: $filterApplication, sorting: $sorting)';
}


}

/// @nodoc
abstract mixin class $SessionLogsFilterStateCopyWith<$Res>  {
  factory $SessionLogsFilterStateCopyWith(SessionLogsFilterState value, $Res Function(SessionLogsFilterState) _then) = _$SessionLogsFilterStateCopyWithImpl;
@useResult
$Res call({
 bool showGrouped, bool blockedOnly, bool allowedOnly, String filterApplication, LogSorting sorting
});




}
/// @nodoc
class _$SessionLogsFilterStateCopyWithImpl<$Res>
    implements $SessionLogsFilterStateCopyWith<$Res> {
  _$SessionLogsFilterStateCopyWithImpl(this._self, this._then);

  final SessionLogsFilterState _self;
  final $Res Function(SessionLogsFilterState) _then;

/// Create a copy of SessionLogsFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showGrouped = null,Object? blockedOnly = null,Object? allowedOnly = null,Object? filterApplication = null,Object? sorting = null,}) {
  return _then(SessionLogsFilterState(
showGrouped: null == showGrouped ? _self.showGrouped : showGrouped // ignore: cast_nullable_to_non_nullable
as bool,blockedOnly: null == blockedOnly ? _self.blockedOnly : blockedOnly // ignore: cast_nullable_to_non_nullable
as bool,allowedOnly: null == allowedOnly ? _self.allowedOnly : allowedOnly // ignore: cast_nullable_to_non_nullable
as bool,filterApplication: null == filterApplication ? _self.filterApplication : filterApplication // ignore: cast_nullable_to_non_nullable
as String,sorting: null == sorting ? _self.sorting : sorting // ignore: cast_nullable_to_non_nullable
as LogSorting,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionLogsFilterState].
extension SessionLogsFilterStatePatterns on SessionLogsFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
