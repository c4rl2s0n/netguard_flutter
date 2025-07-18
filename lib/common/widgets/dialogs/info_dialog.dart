import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    required this.title,
    required this.content,
    required this.icon,
    super.key,
  });

  final String title;
  final String content;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      icon: icon,
      content: SingleChildScrollView(child: Text(content, softWrap: true)),
      actions: const [ConfirmButton()],
      expand: false,
    );
  }

  static Future<bool> showCustomInfo(
    BuildContext context, {
    String? title,
    String? content,
    Icon? icon,
  }) async {
    return await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => InfoDialog(
            title: title ?? "Did you know this?",
            content: content ?? "So much information...",
            icon: icon ?? const Icon(CustomIcons.info),
          ),
        ) ??
        false;
  }

  static Future<bool> showInfo(
    BuildContext context, {
    String? title,
    String? content,
  }) async {
    return await showCustomInfo(
      context,
      title: title,
      content: content,
      icon: const Icon(CustomIcons.info),
    );
  }

  static Future<bool> showError(BuildContext context, {String? content}) async {
    return await showCustomInfo(
      context,
      title: "Error",
      content: content,
      icon: Icon(CustomIcons.error, color: context.colors.negative),
    );
  }

  static Future<bool> showWarning(
    BuildContext context, {
    String? content,
  }) async {
    return await showCustomInfo(
      context,
      title: "Warning",
      content: content,
      icon: Icon(CustomIcons.warning, color: context.colors.warning),
    );
  }
}
