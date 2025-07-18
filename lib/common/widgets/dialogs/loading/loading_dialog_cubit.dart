import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/widgets/dialogs/loading/loading_result.dart';

part 'loading_dialog_cubit.freezed.dart';

class LoadingDialogCubit extends Cubit<LoadingDialogState> {
  LoadingDialogCubit({bool closeWhenFinished = true})
    : super(LoadingDialogState(closeWhenFinished: closeWhenFinished));

  void setProgress(double? progress) {
    emit(state.copyWith(progress: progress));
  }

  void setTitle(String? title) {
    emit(state.copyWith(title: title));
  }

  void setMessage(String? message) {
    emit(state.copyWith(message: message));
  }

  void setCanInterrupt(bool canInterrupt) =>
      emit(state.copyWith(canInterrupt: canInterrupt));

  void interrupt() {
    if (state.canInterrupt) emit(state.copyWith(interrupt: true));
  }

  void finish({LoadingResult? result}) {
    emit(state.copyWith(result: result, finished: true));
  }
}

@freezed
class LoadingDialogState with _$LoadingDialogState {
  const LoadingDialogState({
    this.finished = false,
    this.closeWhenFinished = false,
    this.canInterrupt = false,
    this.interrupt,
    this.progress,
    this.message,
    this.title,
    this.result,
  });

  @override
  final bool finished;
  @override
  final bool closeWhenFinished;
  @override
  final bool canInterrupt;
  @override
  final bool? interrupt;
  @override
  final double? progress;
  @override
  final String? message;
  @override
  final String? title;
  @override
  final LoadingResult? result;

  bool get showCloseButton => !closeWhenFinished && finished;
  bool get autoClose => closeWhenFinished && finished;
  bool get hasProgress => progress != null;
  bool get stopped => canInterrupt && (interrupt ?? false);
}
