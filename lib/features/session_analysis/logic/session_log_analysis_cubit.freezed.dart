// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_log_analysis_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionLogAnalysisState {

 AnalysisView get view; SessionChartFilterCubit get chartFilterCubit; DateTime? get lastSort; IList<TrafficLog> get logs; TrafficLogGroups get groupedLogs; IMap<String?, IList<TrafficLog>> get logByApplication; IMap<String, IList<TrafficLog>> get logByDestination; IMap<String?, TrafficLogByApplication> get analysisByApplication; IMap<String, TrafficLogByDestination> get analysisByDestination; IList<String?> get applicationsSortedFiltered; IList<String> get destinationsSortedFiltered; VolumeType get volumeType;
/// Create a copy of SessionLogAnalysisState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionLogAnalysisStateCopyWith<SessionLogAnalysisState> get copyWith => _$SessionLogAnalysisStateCopyWithImpl<SessionLogAnalysisState>(this as SessionLogAnalysisState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionLogAnalysisState&&(identical(other.view, view) || other.view == view)&&(identical(other.chartFilterCubit, chartFilterCubit) || other.chartFilterCubit == chartFilterCubit)&&(identical(other.lastSort, lastSort) || other.lastSort == lastSort)&&const DeepCollectionEquality().equals(other.logs, logs)&&(identical(other.groupedLogs, groupedLogs) || other.groupedLogs == groupedLogs)&&(identical(other.logByApplication, logByApplication) || other.logByApplication == logByApplication)&&(identical(other.logByDestination, logByDestination) || other.logByDestination == logByDestination)&&(identical(other.analysisByApplication, analysisByApplication) || other.analysisByApplication == analysisByApplication)&&(identical(other.analysisByDestination, analysisByDestination) || other.analysisByDestination == analysisByDestination)&&const DeepCollectionEquality().equals(other.applicationsSortedFiltered, applicationsSortedFiltered)&&const DeepCollectionEquality().equals(other.destinationsSortedFiltered, destinationsSortedFiltered)&&(identical(other.volumeType, volumeType) || other.volumeType == volumeType));
}


@override
int get hashCode => Object.hash(runtimeType,view,chartFilterCubit,lastSort,const DeepCollectionEquality().hash(logs),groupedLogs,logByApplication,logByDestination,analysisByApplication,analysisByDestination,const DeepCollectionEquality().hash(applicationsSortedFiltered),const DeepCollectionEquality().hash(destinationsSortedFiltered),volumeType);

@override
String toString() {
  return 'SessionLogAnalysisState(view: $view, chartFilterCubit: $chartFilterCubit, lastSort: $lastSort, logs: $logs, groupedLogs: $groupedLogs, logByApplication: $logByApplication, logByDestination: $logByDestination, analysisByApplication: $analysisByApplication, analysisByDestination: $analysisByDestination, applicationsSortedFiltered: $applicationsSortedFiltered, destinationsSortedFiltered: $destinationsSortedFiltered, volumeType: $volumeType)';
}


}

/// @nodoc
abstract mixin class $SessionLogAnalysisStateCopyWith<$Res>  {
  factory $SessionLogAnalysisStateCopyWith(SessionLogAnalysisState value, $Res Function(SessionLogAnalysisState) _then) = _$SessionLogAnalysisStateCopyWithImpl;
@useResult
$Res call({
 AnalysisView view, SessionChartFilterCubit chartFilterCubit, DateTime? lastSort, IList<TrafficLog> logs, TrafficLogGroups groupedLogs, IMap<String?, IList<TrafficLog>> logByApplication, IMap<String, IList<TrafficLog>> logByDestination, IMap<String?, TrafficLogByApplication> analysisByApplication, IMap<String, TrafficLogByDestination> analysisByDestination, IList<String?> applicationsSortedFiltered, IList<String> destinationsSortedFiltered, VolumeType volumeType
});




}
/// @nodoc
class _$SessionLogAnalysisStateCopyWithImpl<$Res>
    implements $SessionLogAnalysisStateCopyWith<$Res> {
  _$SessionLogAnalysisStateCopyWithImpl(this._self, this._then);

  final SessionLogAnalysisState _self;
  final $Res Function(SessionLogAnalysisState) _then;

/// Create a copy of SessionLogAnalysisState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? view = null,Object? chartFilterCubit = null,Object? lastSort = freezed,Object? logs = null,Object? groupedLogs = null,Object? logByApplication = null,Object? logByDestination = null,Object? analysisByApplication = null,Object? analysisByDestination = null,Object? applicationsSortedFiltered = null,Object? destinationsSortedFiltered = null,Object? volumeType = null,}) {
  return _then(SessionLogAnalysisState(
view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as AnalysisView,chartFilterCubit: null == chartFilterCubit ? _self.chartFilterCubit : chartFilterCubit // ignore: cast_nullable_to_non_nullable
as SessionChartFilterCubit,lastSort: freezed == lastSort ? _self.lastSort : lastSort // ignore: cast_nullable_to_non_nullable
as DateTime?,logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as IList<TrafficLog>,groupedLogs: null == groupedLogs ? _self.groupedLogs : groupedLogs // ignore: cast_nullable_to_non_nullable
as TrafficLogGroups,logByApplication: null == logByApplication ? _self.logByApplication : logByApplication // ignore: cast_nullable_to_non_nullable
as IMap<String?, IList<TrafficLog>>,logByDestination: null == logByDestination ? _self.logByDestination : logByDestination // ignore: cast_nullable_to_non_nullable
as IMap<String, IList<TrafficLog>>,analysisByApplication: null == analysisByApplication ? _self.analysisByApplication : analysisByApplication // ignore: cast_nullable_to_non_nullable
as IMap<String?, TrafficLogByApplication>,analysisByDestination: null == analysisByDestination ? _self.analysisByDestination : analysisByDestination // ignore: cast_nullable_to_non_nullable
as IMap<String, TrafficLogByDestination>,applicationsSortedFiltered: null == applicationsSortedFiltered ? _self.applicationsSortedFiltered : applicationsSortedFiltered // ignore: cast_nullable_to_non_nullable
as IList<String?>,destinationsSortedFiltered: null == destinationsSortedFiltered ? _self.destinationsSortedFiltered : destinationsSortedFiltered // ignore: cast_nullable_to_non_nullable
as IList<String>,volumeType: null == volumeType ? _self.volumeType : volumeType // ignore: cast_nullable_to_non_nullable
as VolumeType,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionLogAnalysisState].
extension SessionLogAnalysisStatePatterns on SessionLogAnalysisState {
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
