import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({
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
      borderColor: context.colors.negative,
      icon: const Icon(CustomIcons.delete),
      content: SingleChildScrollView(child: Text(content, softWrap: true)),
      actions: [
        CancelButton(text: declineText),
        DeleteButton(text: confirmText),
      ],
    );
  }

  static Future<bool> ask(
    BuildContext context, {
    required String title,
    required String content,
    String declineText = "Cancel",
    String confirmText = "Delete",
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DeleteConfirmationDialog(
        title: title,
        content: content,
        declineText: declineText,
        confirmText: confirmText,
      ),
    );
  }
}
