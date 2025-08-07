import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({this.returnValue, this.text, super.key});

  final dynamic returnValue;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return DialogActionButton(
      onTap: () => Navigator.maybePop(context, returnValue),
      icon: const Icon(CustomIcons.cancel),
      text: text ?? "Cancel",
      color: context.colors.primary,
    );
  }
}
