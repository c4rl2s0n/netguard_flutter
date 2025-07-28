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

 String? get sessionId; SessionLogsState get sessionLogState; Map<String, Application> get systemApplicationsMap; Map<String, Application> get thirdPartyApplicationsMap;
/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStateCopyWith<SessionState> get copyWith => _$SessionStateCopyWithImpl<SessionState>(this as SessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.sessionLogState, sessionLogState) || other.sessionLogState == sessionLogState)&&const DeepCollectionEquality().equals(other.systemApplicationsMap, systemApplicationsMap)&&const DeepCollectionEquality().equals(other.thirdPartyApplicationsMap, thirdPartyApplicationsMap));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,sessionLogState,const DeepCollectionEquality().hash(systemApplicationsMap),const DeepCollectionEquality().hash(thirdPartyApplicationsMap));

@override
String toString() {
  return 'SessionState(sessionId: $sessionId, sessionLogState: $sessionLogState, systemApplicationsMap: $systemApplicationsMap, thirdPartyApplicationsMap: $thirdPartyApplicationsMap)';
}


}

/// @nodoc
abstract mixin class $SessionStateCopyWith<$Res>  {
  factory $SessionStateCopyWith(SessionState value, $Res Function(SessionState) _then) = _$SessionStateCopyWithImpl;
@useResult
$Res call({
 String? sessionId, SessionLogsState sessionLogState, Map<String, Application> systemApplicationsMap, Map<String, Application> thirdPartyApplicationsMap
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
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = freezed,Object? sessionLogState = null,Object? systemApplicationsMap = null,Object? thirdPartyApplicationsMap = null,}) {
  return _then(SessionState(
sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,sessionLogState: null == sessionLogState ? _self.sessionLogState : sessionLogState // ignore: cast_nullable_to_non_nullable
as SessionLogsState,systemApplicationsMap: null == systemApplicationsMap ? _self.systemApplicationsMap : systemApplicationsMap // ignore: cast_nullable_to_non_nullable
as Map<String, Application>,thirdPartyApplicationsMap: null == thirdPartyApplicationsMap ? _self.thirdPartyApplicationsMap : thirdPartyApplicationsMap // ignore: cast_nullable_to_non_nullable
as Map<String, Application>,
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

/// @nodoc
mixin _$SessionLogsState {

 IList<TrafficLog> get sessionTrafficLog; IMap<String?, IList<TrafficLog>> get sessionTrafficLogByApp; TrafficLogGroups get sessionTrafficLogGroups;
/// Create a copy of SessionLogsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionLogsStateCopyWith<SessionLogsState> get copyWith => _$SessionLogsStateCopyWithImpl<SessionLogsState>(this as SessionLogsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionLogsState&&const DeepCollectionEquality().equals(other.sessionTrafficLog, sessionTrafficLog)&&(identical(other.sessionTrafficLogByApp, sessionTrafficLogByApp) || other.sessionTrafficLogByApp == sessionTrafficLogByApp)&&(identical(other.sessionTrafficLogGroups, sessionTrafficLogGroups) || other.sessionTrafficLogGroups == sessionTrafficLogGroups));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sessionTrafficLog),sessionTrafficLogByApp,sessionTrafficLogGroups);

@override
String toString() {
  return 'SessionLogsState(sessionTrafficLog: $sessionTrafficLog, sessionTrafficLogByApp: $sessionTrafficLogByApp, sessionTrafficLogGroups: $sessionTrafficLogGroups)';
}


}

/// @nodoc
abstract mixin class $SessionLogsStateCopyWith<$Res>  {
  factory $SessionLogsStateCopyWith(SessionLogsState value, $Res Function(SessionLogsState) _then) = _$SessionLogsStateCopyWithImpl;
@useResult
$Res call({
 IList<TrafficLog> sessionTrafficLog, IMap<String?, IList<TrafficLog>> sessionTrafficLogByApp, TrafficLogGroups sessionTrafficLogGroups
});




}
/// @nodoc
class _$SessionLogsStateCopyWithImpl<$Res>
    implements $SessionLogsStateCopyWith<$Res> {
  _$SessionLogsStateCopyWithImpl(this._self, this._then);

  final SessionLogsState _self;
  final $Res Function(SessionLogsState) _then;

/// Create a copy of SessionLogsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionTrafficLog = null,Object? sessionTrafficLogByApp = null,Object? sessionTrafficLogGroups = null,}) {
  return _then(SessionLogsState._(
sessionTrafficLog: null == sessionTrafficLog ? _self.sessionTrafficLog : sessionTrafficLog // ignore: cast_nullable_to_non_nullable
as IList<TrafficLog>,sessionTrafficLogByApp: null == sessionTrafficLogByApp ? _self.sessionTrafficLogByApp : sessionTrafficLogByApp // ignore: cast_nullable_to_non_nullable
as IMap<String?, IList<TrafficLog>>,sessionTrafficLogGroups: null == sessionTrafficLogGroups ? _self.sessionTrafficLogGroups : sessionTrafficLogGroups // ignore: cast_nullable_to_non_nullable
as TrafficLogGroups,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionLogsState].
extension SessionLogsStatePatterns on SessionLogsState {
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
