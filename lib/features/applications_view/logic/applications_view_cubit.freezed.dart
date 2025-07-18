// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applications_view_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplicationsViewState {

 bool get thirdPartyAllEnabled; bool get systemAllEnabled; List<ApplicationEntryCubit> get thirdPartyEntries; List<ApplicationEntryCubit> get systemEntries;
/// Create a copy of ApplicationsViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationsViewStateCopyWith<ApplicationsViewState> get copyWith => _$ApplicationsViewStateCopyWithImpl<ApplicationsViewState>(this as ApplicationsViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationsViewState&&(identical(other.thirdPartyAllEnabled, thirdPartyAllEnabled) || other.thirdPartyAllEnabled == thirdPartyAllEnabled)&&(identical(other.systemAllEnabled, systemAllEnabled) || other.systemAllEnabled == systemAllEnabled)&&const DeepCollectionEquality().equals(other.thirdPartyEntries, thirdPartyEntries)&&const DeepCollectionEquality().equals(other.systemEntries, systemEntries));
}


@override
int get hashCode => Object.hash(runtimeType,thirdPartyAllEnabled,systemAllEnabled,const DeepCollectionEquality().hash(thirdPartyEntries),const DeepCollectionEquality().hash(systemEntries));

@override
String toString() {
  return 'ApplicationsViewState(thirdPartyAllEnabled: $thirdPartyAllEnabled, systemAllEnabled: $systemAllEnabled, thirdPartyEntries: $thirdPartyEntries, systemEntries: $systemEntries)';
}


}

/// @nodoc
abstract mixin class $ApplicationsViewStateCopyWith<$Res>  {
  factory $ApplicationsViewStateCopyWith(ApplicationsViewState value, $Res Function(ApplicationsViewState) _then) = _$ApplicationsViewStateCopyWithImpl;
@useResult
$Res call({
 List<ApplicationEntryCubit> thirdPartyEntries, List<ApplicationEntryCubit> systemEntries, bool thirdPartyAllEnabled, bool systemAllEnabled
});




}
/// @nodoc
class _$ApplicationsViewStateCopyWithImpl<$Res>
    implements $ApplicationsViewStateCopyWith<$Res> {
  _$ApplicationsViewStateCopyWithImpl(this._self, this._then);

  final ApplicationsViewState _self;
  final $Res Function(ApplicationsViewState) _then;

/// Create a copy of ApplicationsViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? thirdPartyEntries = null,Object? systemEntries = null,Object? thirdPartyAllEnabled = null,Object? systemAllEnabled = null,}) {
  return _then(ApplicationsViewState(
thirdPartyEntries: null == thirdPartyEntries ? _self.thirdPartyEntries : thirdPartyEntries // ignore: cast_nullable_to_non_nullable
as List<ApplicationEntryCubit>,systemEntries: null == systemEntries ? _self.systemEntries : systemEntries // ignore: cast_nullable_to_non_nullable
as List<ApplicationEntryCubit>,thirdPartyAllEnabled: null == thirdPartyAllEnabled ? _self.thirdPartyAllEnabled : thirdPartyAllEnabled // ignore: cast_nullable_to_non_nullable
as bool,systemAllEnabled: null == systemAllEnabled ? _self.systemAllEnabled : systemAllEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplicationsViewState].
extension ApplicationsViewStatePatterns on ApplicationsViewState {
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
