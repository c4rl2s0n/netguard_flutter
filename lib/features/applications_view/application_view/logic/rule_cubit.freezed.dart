// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rule_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RuleState {

 String get id; set id(String value); String? get name; set name(String? value); String? get packageName; set packageName(String? value); String? get description; set description(String? value); String? get targetVersion; set targetVersion(String? value); RuleType get type; set type(RuleType value); bool get active; set active(bool value); bool get blockQuic; set blockQuic(bool value); List<String> get hosts; set hosts(List<String> value); List<String> get ips; set ips(List<String> value);
/// Create a copy of RuleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuleStateCopyWith<RuleState> get copyWith => _$RuleStateCopyWithImpl<RuleState>(this as RuleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuleState&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.packageName, packageName) || other.packageName == packageName)&&(identical(other.description, description) || other.description == description)&&(identical(other.targetVersion, targetVersion) || other.targetVersion == targetVersion)&&(identical(other.type, type) || other.type == type)&&(identical(other.active, active) || other.active == active)&&(identical(other.blockQuic, blockQuic) || other.blockQuic == blockQuic)&&const DeepCollectionEquality().equals(other.hosts, hosts)&&const DeepCollectionEquality().equals(other.ips, ips));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,packageName,description,targetVersion,type,active,blockQuic,const DeepCollectionEquality().hash(hosts),const DeepCollectionEquality().hash(ips));

@override
String toString() {
  return 'RuleState(id: $id, name: $name, packageName: $packageName, description: $description, targetVersion: $targetVersion, type: $type, active: $active, blockQuic: $blockQuic, hosts: $hosts, ips: $ips)';
}


}

/// @nodoc
abstract mixin class $RuleStateCopyWith<$Res>  {
  factory $RuleStateCopyWith(RuleState value, $Res Function(RuleState) _then) = _$RuleStateCopyWithImpl;
@useResult
$Res call({
 String id, String? packageName, String? name, String? description, String? targetVersion, RuleType type, bool active, bool blockQuic, List<String> hosts, List<String> ips
});




}
/// @nodoc
class _$RuleStateCopyWithImpl<$Res>
    implements $RuleStateCopyWith<$Res> {
  _$RuleStateCopyWithImpl(this._self, this._then);

  final RuleState _self;
  final $Res Function(RuleState) _then;

/// Create a copy of RuleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? packageName = freezed,Object? name = freezed,Object? description = freezed,Object? targetVersion = freezed,Object? type = null,Object? active = null,Object? blockQuic = null,Object? hosts = null,Object? ips = null,}) {
  return _then(RuleState(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,packageName: freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,targetVersion: freezed == targetVersion ? _self.targetVersion : targetVersion // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RuleType,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,blockQuic: null == blockQuic ? _self.blockQuic : blockQuic // ignore: cast_nullable_to_non_nullable
as bool,hosts: null == hosts ? _self.hosts : hosts // ignore: cast_nullable_to_non_nullable
as List<String>,ips: null == ips ? _self.ips : ips // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RuleState].
extension RuleStatePatterns on RuleState {
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
