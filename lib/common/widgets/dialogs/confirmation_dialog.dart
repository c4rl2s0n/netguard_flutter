import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.title,
    required this.content,
    this.declineText,
    this.confirmText,
    super.key,
  });

  final String title;
  final String content;
  final String? declineText;
  final String? confirmText;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      icon: const Icon(CustomIcons.info),
      content: SingleChildScrollView(child: Text(content, softWrap: true)),
      actions: [
        DeclineButton(text: declineText),
        ConfirmButton(text: confirmText),
      ],
    );
  }

  static Future<bool> ask(
    BuildContext context, {
    String? title,
    String? content,
    String? declineText,
    String? confirmText,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationDialog(
        title: title ?? "Are you sure?",
        content: content ?? "Please confirm!",
        declineText: declineText,
        confirmText: confirmText,
      ),
    );
  }
  static Future<bool?> askOptional(
    BuildContext context, {
    String? title,
    String? content,
    String? declineText,
    String? confirmText,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ConfirmationDialog(
        title: title ?? "Are you sure?",
        content: content ?? "Please confirm!",
        declineText: declineText,
        confirmText: confirmText,
      ),
    );
  }
}
