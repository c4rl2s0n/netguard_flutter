import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({this.returnValue = true, this.text, super.key});

  final dynamic returnValue;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return DialogActionButton(
      onTap: () => Navigator.maybePop(context, returnValue),
      icon: const Icon(CustomIcons.delete),
      text: text ?? "Delete",
      color: context.colors.negative,
    );
  }
}
