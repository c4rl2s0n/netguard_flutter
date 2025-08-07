import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

class LogEntry extends StatelessWidget {
  const LogEntry({
    required this.buildChild,
    required this.allowed,
    this.packageName,
    this.clipboardContent,
    super.key,
  });

  final Widget Function(BuildContext context, VolumeType volumeType) buildChild;
  final bool allowed;
  final String? packageName;
  final String? clipboardContent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) =>
          oldState.applicationsMap != state.applicationsMap,
      builder: (context, session) {
        Application? application = session.applicationsMap[packageName];
        return GestureDetector(
          onTap: clipboardContent.notEmpty ? _writeToClipboard : null,
          child: Row(
            children:
                [
                  application.image,
                  Expanded(child: _child()),
                  _statusIcon(context),
                ].insertBetweenItems(
                  () => const Margin.horizontal(ThemeConstants.spacing),
                ),
          ),
        );
      },
    );
  }

  Widget _child() {
    return BlocSelector<
      SessionLogAnalysisCubit,
      SessionLogAnalysisState,
      VolumeType
    >(
      selector: (state) => state.volumeType,
      builder: (context, volumeType) => buildChild(context, volumeType),
    );
  }

  void _writeToClipboard() async {
    if (clipboardContent.empty) return;
    await Clipboard.setData(ClipboardData(text: clipboardContent!));
    SnackBarFactory.showPositiveSnackBar(
      "Copied '$clipboardContent' to clipboard",
    );
  }

  Widget _statusIcon(BuildContext context) {
    return allowed
        ? Icon(
            CustomIcons.allow,
            color: context.colors.positive,
            size: ThemeConstants.appIconSize,
          )
        : Icon(
            CustomIcons.block,
            color: context.colors.negative,
            size: ThemeConstants.appIconSize,
          );
  }
}
