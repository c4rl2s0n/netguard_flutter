// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_entry_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplicationEntryState {

 Application get app; bool get filter; bool get blockAll; bool get blockQuic; List<RuleCubit> get rules; List<RuleState> get ruleStates;
/// Create a copy of ApplicationEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationEntryStateCopyWith<ApplicationEntryState> get copyWith => _$ApplicationEntryStateCopyWithImpl<ApplicationEntryState>(this as ApplicationEntryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationEntryState&&(identical(other.app, app) || other.app == app)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.blockAll, blockAll) || other.blockAll == blockAll)&&(identical(other.blockQuic, blockQuic) || other.blockQuic == blockQuic)&&const DeepCollectionEquality().equals(other.rules, rules)&&const DeepCollectionEquality().equals(other.ruleStates, ruleStates));
}


@override
int get hashCode => Object.hash(runtimeType,app,filter,blockAll,blockQuic,const DeepCollectionEquality().hash(rules),const DeepCollectionEquality().hash(ruleStates));

@override
String toString() {
  return 'ApplicationEntryState(app: $app, filter: $filter, blockAll: $blockAll, blockQuic: $blockQuic, rules: $rules, ruleStates: $ruleStates)';
}


}

/// @nodoc
abstract mixin class $ApplicationEntryStateCopyWith<$Res>  {
  factory $ApplicationEntryStateCopyWith(ApplicationEntryState value, $Res Function(ApplicationEntryState) _then) = _$ApplicationEntryStateCopyWithImpl;
@useResult
$Res call({
 Application app, bool filter, bool blockAll, bool blockQuic, List<RuleCubit> rules, List<RuleState> ruleStates
});




}
/// @nodoc
class _$ApplicationEntryStateCopyWithImpl<$Res>
    implements $ApplicationEntryStateCopyWith<$Res> {
  _$ApplicationEntryStateCopyWithImpl(this._self, this._then);

  final ApplicationEntryState _self;
  final $Res Function(ApplicationEntryState) _then;

/// Create a copy of ApplicationEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? app = null,Object? filter = null,Object? blockAll = null,Object? blockQuic = null,Object? rules = null,Object? ruleStates = null,}) {
  return _then(ApplicationEntryState(
app: null == app ? _self.app : app // ignore: cast_nullable_to_non_nullable
as Application,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as bool,blockAll: null == blockAll ? _self.blockAll : blockAll // ignore: cast_nullable_to_non_nullable
as bool,blockQuic: null == blockQuic ? _self.blockQuic : blockQuic // ignore: cast_nullable_to_non_nullable
as bool,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<RuleCubit>,ruleStates: null == ruleStates ? _self.ruleStates : ruleStates // ignore: cast_nullable_to_non_nullable
as List<RuleState>,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplicationEntryState].
extension ApplicationEntryStatePatterns on ApplicationEntryState {
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
