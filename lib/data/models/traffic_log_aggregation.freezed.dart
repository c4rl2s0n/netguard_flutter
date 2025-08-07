// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'traffic_log_aggregation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrafficLogAggregation {

 int get latest; int get countAllowed; int get countBlocked; int get sizeAllowed; int get sizeBlocked;
/// Create a copy of TrafficLogAggregation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrafficLogAggregationCopyWith<TrafficLogAggregation> get copyWith => _$TrafficLogAggregationCopyWithImpl<TrafficLogAggregation>(this as TrafficLogAggregation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrafficLogAggregation&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.countAllowed, countAllowed) || other.countAllowed == countAllowed)&&(identical(other.countBlocked, countBlocked) || other.countBlocked == countBlocked)&&(identical(other.sizeAllowed, sizeAllowed) || other.sizeAllowed == sizeAllowed)&&(identical(other.sizeBlocked, sizeBlocked) || other.sizeBlocked == sizeBlocked));
}


@override
int get hashCode => Object.hash(runtimeType,latest,countAllowed,countBlocked,sizeAllowed,sizeBlocked);



}

/// @nodoc
abstract mixin class $TrafficLogAggregationCopyWith<$Res>  {
  factory $TrafficLogAggregationCopyWith(TrafficLogAggregation value, $Res Function(TrafficLogAggregation) _then) = _$TrafficLogAggregationCopyWithImpl;
@useResult
$Res call({
 int latest, int countAllowed, int countBlocked, int sizeAllowed, int sizeBlocked
});




}
/// @nodoc
class _$TrafficLogAggregationCopyWithImpl<$Res>
    implements $TrafficLogAggregationCopyWith<$Res> {
  _$TrafficLogAggregationCopyWithImpl(this._self, this._then);

  final TrafficLogAggregation _self;
  final $Res Function(TrafficLogAggregation) _then;

/// Create a copy of TrafficLogAggregation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latest = null,Object? countAllowed = null,Object? countBlocked = null,Object? sizeAllowed = null,Object? sizeBlocked = null,}) {
  return _then(TrafficLogAggregation(
latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as int,countAllowed: null == countAllowed ? _self.countAllowed : countAllowed // ignore: cast_nullable_to_non_nullable
as int,countBlocked: null == countBlocked ? _self.countBlocked : countBlocked // ignore: cast_nullable_to_non_nullable
as int,sizeAllowed: null == sizeAllowed ? _self.sizeAllowed : sizeAllowed // ignore: cast_nullable_to_non_nullable
as int,sizeBlocked: null == sizeBlocked ? _self.sizeBlocked : sizeBlocked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TrafficLogAggregation].
extension TrafficLogAggregationPatterns on TrafficLogAggregation {
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
mixin _$TrafficLogByApplication {

 Application? get application; int get latest; int get countAllowed; int get countBlocked; int get sizeAllowed; int get sizeBlocked;
/// Create a copy of TrafficLogByApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrafficLogByApplicationCopyWith<TrafficLogByApplication> get copyWith => _$TrafficLogByApplicationCopyWithImpl<TrafficLogByApplication>(this as TrafficLogByApplication, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrafficLogByApplication&&(identical(other.application, application) || other.application == application)&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.countAllowed, countAllowed) || other.countAllowed == countAllowed)&&(identical(other.countBlocked, countBlocked) || other.countBlocked == countBlocked)&&(identical(other.sizeAllowed, sizeAllowed) || other.sizeAllowed == sizeAllowed)&&(identical(other.sizeBlocked, sizeBlocked) || other.sizeBlocked == sizeBlocked));
}


@override
int get hashCode => Object.hash(runtimeType,application,latest,countAllowed,countBlocked,sizeAllowed,sizeBlocked);



}

/// @nodoc
abstract mixin class $TrafficLogByApplicationCopyWith<$Res> implements $TrafficLogAggregationCopyWith<$Res> {
  factory $TrafficLogByApplicationCopyWith(TrafficLogByApplication value, $Res Function(TrafficLogByApplication) _then) = _$TrafficLogByApplicationCopyWithImpl;
@useResult
$Res call({
 Application? application, int latest, int countAllowed, int countBlocked, int sizeAllowed, int sizeBlocked
});




}
/// @nodoc
class _$TrafficLogByApplicationCopyWithImpl<$Res>
    implements $TrafficLogByApplicationCopyWith<$Res> {
  _$TrafficLogByApplicationCopyWithImpl(this._self, this._then);

  final TrafficLogByApplication _self;
  final $Res Function(TrafficLogByApplication) _then;

/// Create a copy of TrafficLogByApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? application = freezed,Object? latest = null,Object? countAllowed = null,Object? countBlocked = null,Object? sizeAllowed = null,Object? sizeBlocked = null,}) {
  return _then(_self.copyWith(
application: freezed == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as Application?,latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as int,countAllowed: null == countAllowed ? _self.countAllowed : countAllowed // ignore: cast_nullable_to_non_nullable
as int,countBlocked: null == countBlocked ? _self.countBlocked : countBlocked // ignore: cast_nullable_to_non_nullable
as int,sizeAllowed: null == sizeAllowed ? _self.sizeAllowed : sizeAllowed // ignore: cast_nullable_to_non_nullable
as int,sizeBlocked: null == sizeBlocked ? _self.sizeBlocked : sizeBlocked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TrafficLogByApplication].
extension TrafficLogByApplicationPatterns on TrafficLogByApplication {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrafficLogByApplication value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrafficLogByApplication() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrafficLogByApplication value)  $default,){
final _that = this;
switch (_that) {
case _TrafficLogByApplication():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrafficLogByApplication value)?  $default,){
final _that = this;
switch (_that) {
case _TrafficLogByApplication() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Application? application,  int latest,  int countAllowed,  int countBlocked,  int sizeAllowed,  int sizeBlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrafficLogByApplication() when $default != null:
return $default(_that.application,_that.latest,_that.countAllowed,_that.countBlocked,_that.sizeAllowed,_that.sizeBlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Application? application,  int latest,  int countAllowed,  int countBlocked,  int sizeAllowed,  int sizeBlocked)  $default,) {final _that = this;
switch (_that) {
case _TrafficLogByApplication():
return $default(_that.application,_that.latest,_that.countAllowed,_that.countBlocked,_that.sizeAllowed,_that.sizeBlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Application? application,  int latest,  int countAllowed,  int countBlocked,  int sizeAllowed,  int sizeBlocked)?  $default,) {final _that = this;
switch (_that) {
case _TrafficLogByApplication() when $default != null:
return $default(_that.application,_that.latest,_that.countAllowed,_that.countBlocked,_that.sizeAllowed,_that.sizeBlocked);case _:
  return null;

}
}

}

/// @nodoc


class _TrafficLogByApplication extends TrafficLogByApplication {
   _TrafficLogByApplication({final  Application? application, final  int latest = 0, final  int countAllowed = 0, final  int countBlocked = 0, final  int sizeAllowed = 0, final  int sizeBlocked = 0}): super._(application: application, latest: latest, countAllowed: countAllowed, countBlocked: countBlocked, sizeAllowed: sizeAllowed, sizeBlocked: sizeBlocked);
  



/// Create a copy of TrafficLogByApplication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrafficLogByApplicationCopyWith<_TrafficLogByApplication> get copyWith => __$TrafficLogByApplicationCopyWithImpl<_TrafficLogByApplication>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrafficLogByApplication&&(identical(other.application, application) || other.application == application)&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.countAllowed, countAllowed) || other.countAllowed == countAllowed)&&(identical(other.countBlocked, countBlocked) || other.countBlocked == countBlocked)&&(identical(other.sizeAllowed, sizeAllowed) || other.sizeAllowed == sizeAllowed)&&(identical(other.sizeBlocked, sizeBlocked) || other.sizeBlocked == sizeBlocked));
}


@override
int get hashCode => Object.hash(runtimeType,application,latest,countAllowed,countBlocked,sizeAllowed,sizeBlocked);



}

/// @nodoc
abstract mixin class _$TrafficLogByApplicationCopyWith<$Res> implements $TrafficLogByApplicationCopyWith<$Res> {
  factory _$TrafficLogByApplicationCopyWith(_TrafficLogByApplication value, $Res Function(_TrafficLogByApplication) _then) = __$TrafficLogByApplicationCopyWithImpl;
@override @useResult
$Res call({
 Application? application, int latest, int countAllowed, int countBlocked, int sizeAllowed, int sizeBlocked
});




}
/// @nodoc
class __$TrafficLogByApplicationCopyWithImpl<$Res>
    implements _$TrafficLogByApplicationCopyWith<$Res> {
  __$TrafficLogByApplicationCopyWithImpl(this._self, this._then);

  final _TrafficLogByApplication _self;
  final $Res Function(_TrafficLogByApplication) _then;

/// Create a copy of TrafficLogByApplication
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? application = freezed,Object? latest = null,Object? countAllowed = null,Object? countBlocked = null,Object? sizeAllowed = null,Object? sizeBlocked = null,}) {
  return _then(_TrafficLogByApplication(
application: freezed == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as Application?,latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as int,countAllowed: null == countAllowed ? _self.countAllowed : countAllowed // ignore: cast_nullable_to_non_nullable
as int,countBlocked: null == countBlocked ? _self.countBlocked : countBlocked // ignore: cast_nullable_to_non_nullable
as int,sizeAllowed: null == sizeAllowed ? _self.sizeAllowed : sizeAllowed // ignore: cast_nullable_to_non_nullable
as int,sizeBlocked: null == sizeBlocked ? _self.sizeBlocked : sizeBlocked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$TrafficLogByDestination {

 String get destination; int get latest; int get countAllowed; int get countBlocked; int get sizeAllowed; int get sizeBlocked;
/// Create a copy of TrafficLogByDestination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrafficLogByDestinationCopyWith<TrafficLogByDestination> get copyWith => _$TrafficLogByDestinationCopyWithImpl<TrafficLogByDestination>(this as TrafficLogByDestination, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrafficLogByDestination&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.countAllowed, countAllowed) || other.countAllowed == countAllowed)&&(identical(other.countBlocked, countBlocked) || other.countBlocked == countBlocked)&&(identical(other.sizeAllowed, sizeAllowed) || other.sizeAllowed == sizeAllowed)&&(identical(other.sizeBlocked, sizeBlocked) || other.sizeBlocked == sizeBlocked));
}


@override
int get hashCode => Object.hash(runtimeType,destination,latest,countAllowed,countBlocked,sizeAllowed,sizeBlocked);



}

/// @nodoc
abstract mixin class $TrafficLogByDestinationCopyWith<$Res> implements $TrafficLogAggregationCopyWith<$Res> {
  factory $TrafficLogByDestinationCopyWith(TrafficLogByDestination value, $Res Function(TrafficLogByDestination) _then) = _$TrafficLogByDestinationCopyWithImpl;
@useResult
$Res call({
 String destination, int latest, int countAllowed, int countBlocked, int sizeAllowed, int sizeBlocked
});




}
/// @nodoc
class _$TrafficLogByDestinationCopyWithImpl<$Res>
    implements $TrafficLogByDestinationCopyWith<$Res> {
  _$TrafficLogByDestinationCopyWithImpl(this._self, this._then);

  final TrafficLogByDestination _self;
  final $Res Function(TrafficLogByDestination) _then;

/// Create a copy of TrafficLogByDestination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? destination = null,Object? latest = null,Object? countAllowed = null,Object? countBlocked = null,Object? sizeAllowed = null,Object? sizeBlocked = null,}) {
  return _then(_self.copyWith(
destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as int,countAllowed: null == countAllowed ? _self.countAllowed : countAllowed // ignore: cast_nullable_to_non_nullable
as int,countBlocked: null == countBlocked ? _self.countBlocked : countBlocked // ignore: cast_nullable_to_non_nullable
as int,sizeAllowed: null == sizeAllowed ? _self.sizeAllowed : sizeAllowed // ignore: cast_nullable_to_non_nullable
as int,sizeBlocked: null == sizeBlocked ? _self.sizeBlocked : sizeBlocked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TrafficLogByDestination].
extension TrafficLogByDestinationPatterns on TrafficLogByDestination {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrafficLogByDestination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrafficLogByDestination() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrafficLogByDestination value)  $default,){
final _that = this;
switch (_that) {
case _TrafficLogByDestination():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrafficLogByDestination value)?  $default,){
final _that = this;
switch (_that) {
case _TrafficLogByDestination() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String destination,  int latest,  int countAllowed,  int countBlocked,  int sizeAllowed,  int sizeBlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrafficLogByDestination() when $default != null:
return $default(_that.destination,_that.latest,_that.countAllowed,_that.countBlocked,_that.sizeAllowed,_that.sizeBlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String destination,  int latest,  int countAllowed,  int countBlocked,  int sizeAllowed,  int sizeBlocked)  $default,) {final _that = this;
switch (_that) {
case _TrafficLogByDestination():
return $default(_that.destination,_that.latest,_that.countAllowed,_that.countBlocked,_that.sizeAllowed,_that.sizeBlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String destination,  int latest,  int countAllowed,  int countBlocked,  int sizeAllowed,  int sizeBlocked)?  $default,) {final _that = this;
switch (_that) {
case _TrafficLogByDestination() when $default != null:
return $default(_that.destination,_that.latest,_that.countAllowed,_that.countBlocked,_that.sizeAllowed,_that.sizeBlocked);case _:
  return null;

}
}

}

/// @nodoc


class _TrafficLogByDestination extends TrafficLogByDestination {
   _TrafficLogByDestination({required final  String destination, final  int latest = 0, final  int countAllowed = 0, final  int countBlocked = 0, final  int sizeAllowed = 0, final  int sizeBlocked = 0}): super._(destination: destination, latest: latest, countAllowed: countAllowed, countBlocked: countBlocked, sizeAllowed: sizeAllowed, sizeBlocked: sizeBlocked);
  



/// Create a copy of TrafficLogByDestination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrafficLogByDestinationCopyWith<_TrafficLogByDestination> get copyWith => __$TrafficLogByDestinationCopyWithImpl<_TrafficLogByDestination>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrafficLogByDestination&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.countAllowed, countAllowed) || other.countAllowed == countAllowed)&&(identical(other.countBlocked, countBlocked) || other.countBlocked == countBlocked)&&(identical(other.sizeAllowed, sizeAllowed) || other.sizeAllowed == sizeAllowed)&&(identical(other.sizeBlocked, sizeBlocked) || other.sizeBlocked == sizeBlocked));
}


@override
int get hashCode => Object.hash(runtimeType,destination,latest,countAllowed,countBlocked,sizeAllowed,sizeBlocked);



}

/// @nodoc
abstract mixin class _$TrafficLogByDestinationCopyWith<$Res> implements $TrafficLogByDestinationCopyWith<$Res> {
  factory _$TrafficLogByDestinationCopyWith(_TrafficLogByDestination value, $Res Function(_TrafficLogByDestination) _then) = __$TrafficLogByDestinationCopyWithImpl;
@override @useResult
$Res call({
 String destination, int latest, int countAllowed, int countBlocked, int sizeAllowed, int sizeBlocked
});




}
/// @nodoc
class __$TrafficLogByDestinationCopyWithImpl<$Res>
    implements _$TrafficLogByDestinationCopyWith<$Res> {
  __$TrafficLogByDestinationCopyWithImpl(this._self, this._then);

  final _TrafficLogByDestination _self;
  final $Res Function(_TrafficLogByDestination) _then;

/// Create a copy of TrafficLogByDestination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? destination = null,Object? latest = null,Object? countAllowed = null,Object? countBlocked = null,Object? sizeAllowed = null,Object? sizeBlocked = null,}) {
  return _then(_TrafficLogByDestination(
destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as int,countAllowed: null == countAllowed ? _self.countAllowed : countAllowed // ignore: cast_nullable_to_non_nullable
as int,countBlocked: null == countBlocked ? _self.countBlocked : countBlocked // ignore: cast_nullable_to_non_nullable
as int,sizeAllowed: null == sizeAllowed ? _self.sizeAllowed : sizeAllowed // ignore: cast_nullable_to_non_nullable
as int,sizeBlocked: null == sizeBlocked ? _self.sizeBlocked : sizeBlocked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$TrafficLogByConnection {

 String? get packageName; int get protocol; int get dport; String get destination; int get latest; int get countAllowed; int get countBlocked; int get sizeAllowed; int get sizeBlocked;
/// Create a copy of TrafficLogByConnection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrafficLogByConnectionCopyWith<TrafficLogByConnection> get copyWith => _$TrafficLogByConnectionCopyWithImpl<TrafficLogByConnection>(this as TrafficLogByConnection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrafficLogByConnection&&(identical(other.packageName, packageName) || other.packageName == packageName)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.dport, dport) || other.dport == dport)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.countAllowed, countAllowed) || other.countAllowed == countAllowed)&&(identical(other.countBlocked, countBlocked) || other.countBlocked == countBlocked)&&(identical(other.sizeAllowed, sizeAllowed) || other.sizeAllowed == sizeAllowed)&&(identical(other.sizeBlocked, sizeBlocked) || other.sizeBlocked == sizeBlocked));
}


@override
int get hashCode => Object.hash(runtimeType,packageName,protocol,dport,destination,latest,countAllowed,countBlocked,sizeAllowed,sizeBlocked);



}

/// @nodoc
abstract mixin class $TrafficLogByConnectionCopyWith<$Res> implements $TrafficLogAggregationCopyWith<$Res> {
  factory $TrafficLogByConnectionCopyWith(TrafficLogByConnection value, $Res Function(TrafficLogByConnection) _then) = _$TrafficLogByConnectionCopyWithImpl;
@useResult
$Res call({
 String? packageName, int protocol, int dport, String destination, int latest, int countAllowed, int countBlocked, int sizeAllowed, int sizeBlocked
});




}
/// @nodoc
class _$TrafficLogByConnectionCopyWithImpl<$Res>
    implements $TrafficLogByConnectionCopyWith<$Res> {
  _$TrafficLogByConnectionCopyWithImpl(this._self, this._then);

  final TrafficLogByConnection _self;
  final $Res Function(TrafficLogByConnection) _then;

/// Create a copy of TrafficLogByConnection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? packageName = freezed,Object? protocol = null,Object? dport = null,Object? destination = null,Object? latest = null,Object? countAllowed = null,Object? countBlocked = null,Object? sizeAllowed = null,Object? sizeBlocked = null,}) {
  return _then(_self.copyWith(
packageName: freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as int,dport: null == dport ? _self.dport : dport // ignore: cast_nullable_to_non_nullable
as int,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as int,countAllowed: null == countAllowed ? _self.countAllowed : countAllowed // ignore: cast_nullable_to_non_nullable
as int,countBlocked: null == countBlocked ? _self.countBlocked : countBlocked // ignore: cast_nullable_to_non_nullable
as int,sizeAllowed: null == sizeAllowed ? _self.sizeAllowed : sizeAllowed // ignore: cast_nullable_to_non_nullable
as int,sizeBlocked: null == sizeBlocked ? _self.sizeBlocked : sizeBlocked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TrafficLogByConnection].
extension TrafficLogByConnectionPatterns on TrafficLogByConnection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrafficLogByConnection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrafficLogByConnection() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrafficLogByConnection value)  $default,){
final _that = this;
switch (_that) {
case _TrafficLogByConnection():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrafficLogByConnection value)?  $default,){
final _that = this;
switch (_that) {
case _TrafficLogByConnection() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? packageName,  int protocol,  int dport,  String destination,  int latest,  int countAllowed,  int countBlocked,  int sizeAllowed,  int sizeBlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrafficLogByConnection() when $default != null:
return $default(_that.packageName,_that.protocol,_that.dport,_that.destination,_that.latest,_that.countAllowed,_that.countBlocked,_that.sizeAllowed,_that.sizeBlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? packageName,  int protocol,  int dport,  String destination,  int latest,  int countAllowed,  int countBlocked,  int sizeAllowed,  int sizeBlocked)  $default,) {final _that = this;
switch (_that) {
case _TrafficLogByConnection():
return $default(_that.packageName,_that.protocol,_that.dport,_that.destination,_that.latest,_that.countAllowed,_that.countBlocked,_that.sizeAllowed,_that.sizeBlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? packageName,  int protocol,  int dport,  String destination,  int latest,  int countAllowed,  int countBlocked,  int sizeAllowed,  int sizeBlocked)?  $default,) {final _that = this;
switch (_that) {
case _TrafficLogByConnection() when $default != null:
return $default(_that.packageName,_that.protocol,_that.dport,_that.destination,_that.latest,_that.countAllowed,_that.countBlocked,_that.sizeAllowed,_that.sizeBlocked);case _:
  return null;

}
}

}

/// @nodoc


class _TrafficLogByConnection extends TrafficLogByConnection {
   _TrafficLogByConnection({final  String? packageName, required final  int protocol, required final  int dport, required final  String destination, final  int latest = 0, final  int countAllowed = 0, final  int countBlocked = 0, final  int sizeAllowed = 0, final  int sizeBlocked = 0}): super._(packageName: packageName, protocol: protocol, dport: dport, destination: destination, latest: latest, countAllowed: countAllowed, countBlocked: countBlocked, sizeAllowed: sizeAllowed, sizeBlocked: sizeBlocked);
  



/// Create a copy of TrafficLogByConnection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrafficLogByConnectionCopyWith<_TrafficLogByConnection> get copyWith => __$TrafficLogByConnectionCopyWithImpl<_TrafficLogByConnection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrafficLogByConnection&&(identical(other.packageName, packageName) || other.packageName == packageName)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.dport, dport) || other.dport == dport)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.countAllowed, countAllowed) || other.countAllowed == countAllowed)&&(identical(other.countBlocked, countBlocked) || other.countBlocked == countBlocked)&&(identical(other.sizeAllowed, sizeAllowed) || other.sizeAllowed == sizeAllowed)&&(identical(other.sizeBlocked, sizeBlocked) || other.sizeBlocked == sizeBlocked));
}


@override
int get hashCode => Object.hash(runtimeType,packageName,protocol,dport,destination,latest,countAllowed,countBlocked,sizeAllowed,sizeBlocked);



}

/// @nodoc
abstract mixin class _$TrafficLogByConnectionCopyWith<$Res> implements $TrafficLogByConnectionCopyWith<$Res> {
  factory _$TrafficLogByConnectionCopyWith(_TrafficLogByConnection value, $Res Function(_TrafficLogByConnection) _then) = __$TrafficLogByConnectionCopyWithImpl;
@override @useResult
$Res call({
 String? packageName, int protocol, int dport, String destination, int latest, int countAllowed, int countBlocked, int sizeAllowed, int sizeBlocked
});




}
/// @nodoc
class __$TrafficLogByConnectionCopyWithImpl<$Res>
    implements _$TrafficLogByConnectionCopyWith<$Res> {
  __$TrafficLogByConnectionCopyWithImpl(this._self, this._then);

  final _TrafficLogByConnection _self;
  final $Res Function(_TrafficLogByConnection) _then;

/// Create a copy of TrafficLogByConnection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? packageName = freezed,Object? protocol = null,Object? dport = null,Object? destination = null,Object? latest = null,Object? countAllowed = null,Object? countBlocked = null,Object? sizeAllowed = null,Object? sizeBlocked = null,}) {
  return _then(_TrafficLogByConnection(
packageName: freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,protocol: null == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as int,dport: null == dport ? _self.dport : dport // ignore: cast_nullable_to_non_nullable
as int,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as int,countAllowed: null == countAllowed ? _self.countAllowed : countAllowed // ignore: cast_nullable_to_non_nullable
as int,countBlocked: null == countBlocked ? _self.countBlocked : countBlocked // ignore: cast_nullable_to_non_nullable
as int,sizeAllowed: null == sizeAllowed ? _self.sizeAllowed : sizeAllowed // ignore: cast_nullable_to_non_nullable
as int,sizeBlocked: null == sizeBlocked ? _self.sizeBlocked : sizeBlocked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
