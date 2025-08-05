// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 bool get darkMode; FlexScheme get colorScheme; bool get includeSystemApps; bool get logTraffic; bool get observeOnly; bool get logCompactView; DateTime? get lastHostlistUpdate; VolumeType get analysisVolumeType; GroupType get analysisChartGroupType; ChartType get analysisChartType; LogSorting get analysisChartSorting; bool get analysisChartSingleBar;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.darkMode, darkMode) || other.darkMode == darkMode)&&(identical(other.colorScheme, colorScheme) || other.colorScheme == colorScheme)&&(identical(other.includeSystemApps, includeSystemApps) || other.includeSystemApps == includeSystemApps)&&(identical(other.logTraffic, logTraffic) || other.logTraffic == logTraffic)&&(identical(other.observeOnly, observeOnly) || other.observeOnly == observeOnly)&&(identical(other.logCompactView, logCompactView) || other.logCompactView == logCompactView)&&(identical(other.lastHostlistUpdate, lastHostlistUpdate) || other.lastHostlistUpdate == lastHostlistUpdate)&&(identical(other.analysisVolumeType, analysisVolumeType) || other.analysisVolumeType == analysisVolumeType)&&(identical(other.analysisChartGroupType, analysisChartGroupType) || other.analysisChartGroupType == analysisChartGroupType)&&(identical(other.analysisChartType, analysisChartType) || other.analysisChartType == analysisChartType)&&(identical(other.analysisChartSorting, analysisChartSorting) || other.analysisChartSorting == analysisChartSorting)&&(identical(other.analysisChartSingleBar, analysisChartSingleBar) || other.analysisChartSingleBar == analysisChartSingleBar));
}


@override
int get hashCode => Object.hash(runtimeType,darkMode,colorScheme,includeSystemApps,logTraffic,observeOnly,logCompactView,lastHostlistUpdate,analysisVolumeType,analysisChartGroupType,analysisChartType,analysisChartSorting,analysisChartSingleBar);

@override
String toString() {
  return 'SettingsState(darkMode: $darkMode, colorScheme: $colorScheme, includeSystemApps: $includeSystemApps, logTraffic: $logTraffic, observeOnly: $observeOnly, logCompactView: $logCompactView, lastHostlistUpdate: $lastHostlistUpdate, analysisVolumeType: $analysisVolumeType, analysisChartGroupType: $analysisChartGroupType, analysisChartType: $analysisChartType, analysisChartSorting: $analysisChartSorting, analysisChartSingleBar: $analysisChartSingleBar)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 bool darkMode, FlexScheme colorScheme, bool includeSystemApps, bool logTraffic, bool observeOnly, bool logCompactView, DateTime? lastHostlistUpdate, VolumeType analysisVolumeType, GroupType analysisChartGroupType, ChartType analysisChartType, LogSorting analysisChartSorting, bool analysisChartSingleBar
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? darkMode = null,Object? colorScheme = null,Object? includeSystemApps = null,Object? logTraffic = null,Object? observeOnly = null,Object? logCompactView = null,Object? lastHostlistUpdate = freezed,Object? analysisVolumeType = null,Object? analysisChartGroupType = null,Object? analysisChartType = null,Object? analysisChartSorting = null,Object? analysisChartSingleBar = null,}) {
  return _then(SettingsState(
darkMode: null == darkMode ? _self.darkMode : darkMode // ignore: cast_nullable_to_non_nullable
as bool,colorScheme: null == colorScheme ? _self.colorScheme : colorScheme // ignore: cast_nullable_to_non_nullable
as FlexScheme,includeSystemApps: null == includeSystemApps ? _self.includeSystemApps : includeSystemApps // ignore: cast_nullable_to_non_nullable
as bool,logTraffic: null == logTraffic ? _self.logTraffic : logTraffic // ignore: cast_nullable_to_non_nullable
as bool,observeOnly: null == observeOnly ? _self.observeOnly : observeOnly // ignore: cast_nullable_to_non_nullable
as bool,logCompactView: null == logCompactView ? _self.logCompactView : logCompactView // ignore: cast_nullable_to_non_nullable
as bool,lastHostlistUpdate: freezed == lastHostlistUpdate ? _self.lastHostlistUpdate : lastHostlistUpdate // ignore: cast_nullable_to_non_nullable
as DateTime?,analysisVolumeType: null == analysisVolumeType ? _self.analysisVolumeType : analysisVolumeType // ignore: cast_nullable_to_non_nullable
as VolumeType,analysisChartGroupType: null == analysisChartGroupType ? _self.analysisChartGroupType : analysisChartGroupType // ignore: cast_nullable_to_non_nullable
as GroupType,analysisChartType: null == analysisChartType ? _self.analysisChartType : analysisChartType // ignore: cast_nullable_to_non_nullable
as ChartType,analysisChartSorting: null == analysisChartSorting ? _self.analysisChartSorting : analysisChartSorting // ignore: cast_nullable_to_non_nullable
as LogSorting,analysisChartSingleBar: null == analysisChartSingleBar ? _self.analysisChartSingleBar : analysisChartSingleBar // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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
