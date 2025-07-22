import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';

typedef InterruptButtonBuilder = Widget Function(Function? onTap);

class LoadingDialog extends StatelessWidget {
  const LoadingDialog(
    this.loadingDialogCubit, {
    this.interruptButton,
    super.key,
  });

  final LoadingCubit loadingDialogCubit;

  final InterruptButtonBuilder? interruptButton;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => loadingDialogCubit,
      child: BlocBuilder<LoadingCubit, LoadingState>(
        buildWhen: (oldState, state) =>
            oldState.finished != state.finished ||
            oldState.title != state.title ||
            oldState.progress != state.progress ||
            oldState.showCloseButton != state.showCloseButton ||
            oldState.canInterrupt != state.canInterrupt,
        builder: (context, state) {
          return CustomDialog(
            title: state.hasError ? "Error" : state.title ?? "Loading",
            icon: state.hasError
                ? Icon(CustomIcons.error, color: context.colors.error,)
                : state.finished
                ? const Icon(CustomIcons.infoPositive)
                : const Icon(CustomIcons.loading),
            borderColor: state.hasError ? context.colors.error : null,
            expand: false,
            actions: _buildActions(context, state),
            content: BlocConsumer<LoadingCubit, LoadingState>(
              listenWhen: (oldState, state) =>
                  oldState.autoClose != state.autoClose ||
                  oldState.result != state.result,
              listener: (context, state) =>
                  state.autoClose ? context.navigator.pop(state.result) : null,
              builder: (context, state) {
                return state.hasError
                    ? Text(state.error!.toString())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!state.finished) ...[
                            InformativeProgressIndicator(
                              progress: state.progress,
                            ),
                            const Margin.vertical(ThemeConstants.spacing),
                          ],
                          if (state.message.notEmpty) Text(state.message!),
                          if (state.stopped)
                            Text(
                              "Interrupted!",
                              style: context.textTheme.titleMedium?.copyWith(
                                color: context.colors.warning,
                              ),
                            ),
                        ],
                      );
              },
            ),
          );
        },
      ),
    );
  }

  List<Widget>? _buildActions(BuildContext context, LoadingState state) {
    if (!(state.showCloseButton || state.canInterrupt)) return null;
    return [
      if (state.canInterrupt) _interruptButton(),
      if (state.showCloseButton) _closeButton(),
    ];
  }

  Widget _interruptButton() {
    return BlocBuilder<LoadingCubit, LoadingState>(
      buildWhen: (oldState, state) =>
          oldState.canInterrupt != state.canInterrupt ||
          oldState.interrupt != state.interrupt,
      builder: (context, state) {
        Function()? onTap = state.canInterrupt && !state.stopped
            ? loadingDialogCubit.interrupt
            : null;
        return interruptButton?.call(onTap) ??
            DialogActionButton(
              icon: const Icon(CustomIcons.warning),
              text: "Stop",
              color: context.colors.warning,
              onTap: onTap,
            );
      },
    );
  }

  Widget _closeButton() {
    return BlocBuilder<LoadingCubit, LoadingState>(
      buildWhen: (oldState, state) =>
          oldState.result != state.result ||
          oldState.showCloseButton != state.showCloseButton,
      builder: (context, state) {
        return ConfirmButton(text: "Close", returnValue: state.result);
      },
    );
  }

  static Future<LoadingResult?> show(
    BuildContext context,
    Future Function(BuildContext, LoadingCubit) task, {
    InterruptButtonBuilder? interruptButton,
    bool closeWhenFinished = true,
  }) async {
    LoadingCubit cubit = LoadingCubit.dialog(
      closeWhenFinished: closeWhenFinished,
    );
    task(context, cubit);
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          LoadingDialog(cubit, interruptButton: interruptButton),
    );
  }
}
