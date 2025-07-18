import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';
import 'package:netguard/common/keys.dart';

extension SnackBarTextTheme on BuildContext {
  TextStyle? get messageStyle => textTheme.bodyMedium;
}

class SnackBarFactory {
  static Duration _defaultSnackBarDuration = const Duration(milliseconds: 4000);
  static void showSnackBar(
    SnackBar Function(BuildContext context) buildSnackBar,
  ) {
    BuildContext? context = messengerKey.currentContext;
    if (context == null) {
      LoggingService.onError(
        const FlutterErrorDetails(
          exception: "No context for SnackBar...",
          library: "SnackBarFactory",
        ),
      );
      return;
    }
    messengerKey.currentState?.showSnackBar(buildSnackBar(context));
  }

  static void showPositiveSnackBar(String message) =>
      showSnackBar((c) => getPositiveSnackBar(c, text: message));
  static void showWarningSnackBar(String message) =>
      showSnackBar((c) => getWarningSnackBar(c, text: message));
  static void showNegativeSnackBar(String message, {Duration? duration}) =>
      showSnackBar(
        (c) => getNegativeSnackBar(c, text: message, duration: duration),
      );
  static void showInfoSnackBar(String message) =>
      showSnackBar((c) => getInfoSnackBar(c, text: message));

  static SnackBar _basicSnackBar(
    BuildContext context, {
    required String text,
    IconData? icon,
    Color? textColor,
    Color? snackBarColor,
    Duration? duration,
  }) {
    return SnackBar(
      margin: const EdgeInsets.all(ThemeConstants.smallSpacing),
      behavior: SnackBarBehavior.floating,
      duration: duration ?? _defaultSnackBarDuration,
      content: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor),
            const Margin.horizontal(ThemeConstants.spacing),
          ],
          Expanded(
            child: Text(
              text,
              style: context.messageStyle?.copyWith(color: textColor),
            ),
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: ThemeConstants.borderRadius,
      ),
      padding: const EdgeInsets.all(ThemeConstants.spacing),
      showCloseIcon: true,
      backgroundColor: snackBarColor,
    );
  }

  static SnackBar getInfoSnackBar(
    BuildContext context, {
    required String text,
  }) => _basicSnackBar(
    context,
    text: text,
    icon: CustomIcons.info,
    textColor: context.colors.onSurface,
    snackBarColor: context.colors.surfaceContainerHighest,
  );

  static SnackBar getPositiveSnackBar(
    BuildContext context, {
    required String text,
  }) => _basicSnackBar(
    context,
    text: text,
    icon: CustomIcons.infoPositive,
    textColor: context.colors.onPositive,
    snackBarColor: context.colors.positive,
  );

  static SnackBar getWarningSnackBar(
    BuildContext context, {
    required String text,
  }) => _basicSnackBar(
    context,
    text: text,
    icon: CustomIcons.warning,
    textColor: context.colors.onWarning,
    snackBarColor: context.colors.warning,
  );

  static SnackBar getNegativeSnackBar(
    BuildContext context, {
    required String text,
    Duration? duration,
  }) => _basicSnackBar(
    context,
    text: text,
    icon: CustomIcons.infoNegative,
    textColor: context.colors.onNegative,
    snackBarColor: context.colors.negative,
  );
}
