// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loading_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoadingState {

 bool get finished; bool get canInterrupt; bool get closeDialogWhenFinished; bool? get interrupt; double? get progress; String? get message; Object? get error; String? get title; LoadingResult? get result;
/// Create a copy of LoadingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadingStateCopyWith<LoadingState> get copyWith => _$LoadingStateCopyWithImpl<LoadingState>(this as LoadingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingState&&(identical(other.finished, finished) || other.finished == finished)&&(identical(other.canInterrupt, canInterrupt) || other.canInterrupt == canInterrupt)&&(identical(other.closeDialogWhenFinished, closeDialogWhenFinished) || other.closeDialogWhenFinished == closeDialogWhenFinished)&&(identical(other.interrupt, interrupt) || other.interrupt == interrupt)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.title, title) || other.title == title)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,finished,canInterrupt,closeDialogWhenFinished,interrupt,progress,message,const DeepCollectionEquality().hash(error),title,result);

@override
String toString() {
  return 'LoadingState(finished: $finished, canInterrupt: $canInterrupt, closeDialogWhenFinished: $closeDialogWhenFinished, interrupt: $interrupt, progress: $progress, message: $message, error: $error, title: $title, result: $result)';
}


}

/// @nodoc
abstract mixin class $LoadingStateCopyWith<$Res>  {
  factory $LoadingStateCopyWith(LoadingState value, $Res Function(LoadingState) _then) = _$LoadingStateCopyWithImpl;
@useResult
$Res call({
 bool finished, bool canInterrupt, bool closeDialogWhenFinished, bool? interrupt, double? progress, String? message, Object? error, String? title, LoadingResult? result
});




}
/// @nodoc
class _$LoadingStateCopyWithImpl<$Res>
    implements $LoadingStateCopyWith<$Res> {
  _$LoadingStateCopyWithImpl(this._self, this._then);

  final LoadingState _self;
  final $Res Function(LoadingState) _then;

/// Create a copy of LoadingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? finished = null,Object? canInterrupt = null,Object? closeDialogWhenFinished = null,Object? interrupt = freezed,Object? progress = freezed,Object? message = freezed,Object? error = freezed,Object? title = freezed,Object? result = freezed,}) {
  return _then(LoadingState(
finished: null == finished ? _self.finished : finished // ignore: cast_nullable_to_non_nullable
as bool,canInterrupt: null == canInterrupt ? _self.canInterrupt : canInterrupt // ignore: cast_nullable_to_non_nullable
as bool,closeDialogWhenFinished: null == closeDialogWhenFinished ? _self.closeDialogWhenFinished : closeDialogWhenFinished // ignore: cast_nullable_to_non_nullable
as bool,interrupt: freezed == interrupt ? _self.interrupt : interrupt // ignore: cast_nullable_to_non_nullable
as bool?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error ,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as LoadingResult?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoadingState].
extension LoadingStatePatterns on LoadingState {
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
