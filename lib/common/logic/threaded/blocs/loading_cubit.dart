import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../loading_result.dart';

part 'loading_cubit.freezed.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingState());
  LoadingCubit.dialog({bool closeWhenFinished = false})
    : super(LoadingState(closeDialogWhenFinished: closeWhenFinished));

  void setProgress(double? progress) {
    emit(state.copyWith(progress: progress));
  }

  void setTitle(String? title) {
    emit(state.copyWith(title: title));
  }

  void setMessage(String? message) {
    emit(state.copyWith(message: message));
  }

  void setError(Object? error) {
    emit(state.copyWith(error: error));
  }

  void setCanInterrupt(bool canInterrupt) =>
      emit(state.copyWith(canInterrupt: canInterrupt));

  void interrupt() {
    if (state.canInterrupt) emit(state.copyWith(interrupt: true));
  }

  void finish({LoadingResult? result}) {
    emit(state.copyWith(result: result, finished: true));
  }

  void pushState(LoadingState state) => emit(state);
}

@freezed
class LoadingState with _$LoadingState {
  const LoadingState({
    this.finished = false,
    this.canInterrupt = false,
    this.closeDialogWhenFinished = false,
    this.interrupt,
    this.progress,
    this.message,
    this.error,
    this.title,
    this.result,
  });

  @override
  final bool finished;
  @override
  final bool canInterrupt;
  @override
  final bool closeDialogWhenFinished;
  @override
  final bool? interrupt;
  @override
  final double? progress;
  @override
  final String? message;
  @override
  final Object? error;
  @override
  final String? title;
  @override
  final LoadingResult? result;

  bool get showCloseButton => hasError || !closeDialogWhenFinished && finished;
  bool get autoClose => closeDialogWhenFinished && finished;
  bool get hasError => error != null;
  bool get hasProgress => progress != null;
  bool get stopped => hasError || canInterrupt && (interrupt ?? false);
}
