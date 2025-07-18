// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loading_dialog_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoadingDialogState {

 bool get finished; bool get closeWhenFinished; bool get canInterrupt; bool? get interrupt; double? get progress; String? get message; String? get title; LoadingResult? get result;
/// Create a copy of LoadingDialogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadingDialogStateCopyWith<LoadingDialogState> get copyWith => _$LoadingDialogStateCopyWithImpl<LoadingDialogState>(this as LoadingDialogState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingDialogState&&(identical(other.finished, finished) || other.finished == finished)&&(identical(other.closeWhenFinished, closeWhenFinished) || other.closeWhenFinished == closeWhenFinished)&&(identical(other.canInterrupt, canInterrupt) || other.canInterrupt == canInterrupt)&&(identical(other.interrupt, interrupt) || other.interrupt == interrupt)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.message, message) || other.message == message)&&(identical(other.title, title) || other.title == title)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,finished,closeWhenFinished,canInterrupt,interrupt,progress,message,title,result);

@override
String toString() {
  return 'LoadingDialogState(finished: $finished, closeWhenFinished: $closeWhenFinished, canInterrupt: $canInterrupt, interrupt: $interrupt, progress: $progress, message: $message, title: $title, result: $result)';
}


}

/// @nodoc
abstract mixin class $LoadingDialogStateCopyWith<$Res>  {
  factory $LoadingDialogStateCopyWith(LoadingDialogState value, $Res Function(LoadingDialogState) _then) = _$LoadingDialogStateCopyWithImpl;
@useResult
$Res call({
 bool finished, bool closeWhenFinished, bool canInterrupt, bool? interrupt, double? progress, String? message, String? title, LoadingResult? result
});




}
/// @nodoc
class _$LoadingDialogStateCopyWithImpl<$Res>
    implements $LoadingDialogStateCopyWith<$Res> {
  _$LoadingDialogStateCopyWithImpl(this._self, this._then);

  final LoadingDialogState _self;
  final $Res Function(LoadingDialogState) _then;

/// Create a copy of LoadingDialogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? finished = null,Object? closeWhenFinished = null,Object? canInterrupt = null,Object? interrupt = freezed,Object? progress = freezed,Object? message = freezed,Object? title = freezed,Object? result = freezed,}) {
  return _then(LoadingDialogState(
finished: null == finished ? _self.finished : finished // ignore: cast_nullable_to_non_nullable
as bool,closeWhenFinished: null == closeWhenFinished ? _self.closeWhenFinished : closeWhenFinished // ignore: cast_nullable_to_non_nullable
as bool,canInterrupt: null == canInterrupt ? _self.canInterrupt : canInterrupt // ignore: cast_nullable_to_non_nullable
as bool,interrupt: freezed == interrupt ? _self.interrupt : interrupt // ignore: cast_nullable_to_non_nullable
as bool?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as LoadingResult?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoadingDialogState].
extension LoadingDialogStatePatterns on LoadingDialogState {
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
