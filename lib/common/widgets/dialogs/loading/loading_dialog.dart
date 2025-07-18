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

  final LoadingDialogCubit loadingDialogCubit;

  final InterruptButtonBuilder? interruptButton;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => loadingDialogCubit,
      child: BlocBuilder<LoadingDialogCubit, LoadingDialogState>(
        buildWhen: (oldState, state) =>
            oldState.finished != state.finished ||
            oldState.title != state.title ||
            oldState.progress != state.progress ||
            oldState.showCloseButton != state.showCloseButton ||
            oldState.canInterrupt != state.canInterrupt,
        builder: (context, state) {
          return CustomDialog(
            title: state.title ?? "Loading",
            icon: state.finished
                ? const Icon(CustomIcons.infoPositive)
                : const Icon(CustomIcons.loading),
            expand: false,
            actions: _buildActions(
              context,
              showCloseButton: state.showCloseButton,
              showInterruptButton: state.canInterrupt,
            ),
            content: BlocConsumer<LoadingDialogCubit, LoadingDialogState>(
              listenWhen: (oldState, state) =>
                  oldState.autoClose != state.autoClose ||
                  oldState.result != state.result,
              listener: (context, state) =>
                  state.autoClose ? context.navigator.pop(state.result) : null,
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!state.finished) ...[
                      InformativeProgressIndicator(progress: state.progress),
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

  List<Widget>? _buildActions(
    BuildContext context, {
    bool showCloseButton = false,
    bool showInterruptButton = false,
  }) {
    if (!(showCloseButton || showInterruptButton)) return null;
    return [
      if (showInterruptButton) _interruptButton(),
      if (showCloseButton) _closeButton(),
    ];
  }

  Widget _interruptButton() {
    return BlocBuilder<LoadingDialogCubit, LoadingDialogState>(
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
    return BlocBuilder<LoadingDialogCubit, LoadingDialogState>(
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
    Future Function(BuildContext, LoadingDialogCubit) task, {
    InterruptButtonBuilder? interruptButton,
    bool closeWhenFinished = true,
  }) async {
    LoadingDialogCubit cubit = LoadingDialogCubit(
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
