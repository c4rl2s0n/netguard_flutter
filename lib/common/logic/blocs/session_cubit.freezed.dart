// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionState {

 VpnConfig? get sessionConfig; bool get running; SessionLogAnalysisCubit get sessionAnalysis; Map<String, Application> get systemApplicationsMap; Map<String, Application> get thirdPartyApplicationsMap; SessionStatistics get sessionStatistics;
/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStateCopyWith<SessionState> get copyWith => _$SessionStateCopyWithImpl<SessionState>(this as SessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState&&(identical(other.sessionConfig, sessionConfig) || other.sessionConfig == sessionConfig)&&(identical(other.running, running) || other.running == running)&&(identical(other.sessionAnalysis, sessionAnalysis) || other.sessionAnalysis == sessionAnalysis)&&const DeepCollectionEquality().equals(other.systemApplicationsMap, systemApplicationsMap)&&const DeepCollectionEquality().equals(other.thirdPartyApplicationsMap, thirdPartyApplicationsMap)&&(identical(other.sessionStatistics, sessionStatistics) || other.sessionStatistics == sessionStatistics));
}


@override
int get hashCode => Object.hash(runtimeType,sessionConfig,running,sessionAnalysis,const DeepCollectionEquality().hash(systemApplicationsMap),const DeepCollectionEquality().hash(thirdPartyApplicationsMap),sessionStatistics);

@override
String toString() {
  return 'SessionState(sessionConfig: $sessionConfig, running: $running, sessionAnalysis: $sessionAnalysis, systemApplicationsMap: $systemApplicationsMap, thirdPartyApplicationsMap: $thirdPartyApplicationsMap, sessionStatistics: $sessionStatistics)';
}


}

/// @nodoc
abstract mixin class $SessionStateCopyWith<$Res>  {
  factory $SessionStateCopyWith(SessionState value, $Res Function(SessionState) _then) = _$SessionStateCopyWithImpl;
@useResult
$Res call({
 VpnConfig? sessionConfig, bool running, SessionLogAnalysisCubit sessionAnalysis, Map<String, Application> systemApplicationsMap, Map<String, Application> thirdPartyApplicationsMap, SessionStatistics sessionStatistics
});




}
/// @nodoc
class _$SessionStateCopyWithImpl<$Res>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._self, this._then);

  final SessionState _self;
  final $Res Function(SessionState) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionConfig = freezed,Object? running = null,Object? sessionAnalysis = null,Object? systemApplicationsMap = null,Object? thirdPartyApplicationsMap = null,Object? sessionStatistics = null,}) {
  return _then(SessionState(
sessionConfig: freezed == sessionConfig ? _self.sessionConfig : sessionConfig // ignore: cast_nullable_to_non_nullable
as VpnConfig?,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,sessionAnalysis: null == sessionAnalysis ? _self.sessionAnalysis : sessionAnalysis // ignore: cast_nullable_to_non_nullable
as SessionLogAnalysisCubit,systemApplicationsMap: null == systemApplicationsMap ? _self.systemApplicationsMap : systemApplicationsMap // ignore: cast_nullable_to_non_nullable
as Map<String, Application>,thirdPartyApplicationsMap: null == thirdPartyApplicationsMap ? _self.thirdPartyApplicationsMap : thirdPartyApplicationsMap // ignore: cast_nullable_to_non_nullable
as Map<String, Application>,sessionStatistics: null == sessionStatistics ? _self.sessionStatistics : sessionStatistics // ignore: cast_nullable_to_non_nullable
as SessionStatistics,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionState].
extension SessionStatePatterns on SessionState {
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
