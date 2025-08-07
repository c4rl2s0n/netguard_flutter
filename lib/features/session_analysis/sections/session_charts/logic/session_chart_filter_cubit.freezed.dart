// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_chart_filter_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionChartFilterState {

 List<Application?> get filterApplications; LogSorting get sorting; bool get singleBar; ChartType get chartType; GroupType get groupType;
/// Create a copy of SessionChartFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionChartFilterStateCopyWith<SessionChartFilterState> get copyWith => _$SessionChartFilterStateCopyWithImpl<SessionChartFilterState>(this as SessionChartFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionChartFilterState&&const DeepCollectionEquality().equals(other.filterApplications, filterApplications)&&(identical(other.sorting, sorting) || other.sorting == sorting)&&(identical(other.singleBar, singleBar) || other.singleBar == singleBar)&&(identical(other.chartType, chartType) || other.chartType == chartType)&&(identical(other.groupType, groupType) || other.groupType == groupType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(filterApplications),sorting,singleBar,chartType,groupType);

@override
String toString() {
  return 'SessionChartFilterState(filterApplications: $filterApplications, sorting: $sorting, singleBar: $singleBar, chartType: $chartType, groupType: $groupType)';
}


}

/// @nodoc
abstract mixin class $SessionChartFilterStateCopyWith<$Res>  {
  factory $SessionChartFilterStateCopyWith(SessionChartFilterState value, $Res Function(SessionChartFilterState) _then) = _$SessionChartFilterStateCopyWithImpl;
@useResult
$Res call({
 List<Application?> filterApplications, LogSorting sorting, ChartType chartType, bool singleBar, GroupType groupType
});




}
/// @nodoc
class _$SessionChartFilterStateCopyWithImpl<$Res>
    implements $SessionChartFilterStateCopyWith<$Res> {
  _$SessionChartFilterStateCopyWithImpl(this._self, this._then);

  final SessionChartFilterState _self;
  final $Res Function(SessionChartFilterState) _then;

/// Create a copy of SessionChartFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filterApplications = null,Object? sorting = null,Object? chartType = null,Object? singleBar = null,Object? groupType = null,}) {
  return _then(SessionChartFilterState._(
filterApplications: null == filterApplications ? _self.filterApplications : filterApplications // ignore: cast_nullable_to_non_nullable
as List<Application?>,sorting: null == sorting ? _self.sorting : sorting // ignore: cast_nullable_to_non_nullable
as LogSorting,chartType: null == chartType ? _self.chartType : chartType // ignore: cast_nullable_to_non_nullable
as ChartType,singleBar: null == singleBar ? _self.singleBar : singleBar // ignore: cast_nullable_to_non_nullable
as bool,groupType: null == groupType ? _self.groupType : groupType // ignore: cast_nullable_to_non_nullable
as GroupType,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionChartFilterState].
extension SessionChartFilterStatePatterns on SessionChartFilterState {
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
