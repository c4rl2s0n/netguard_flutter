import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class DeclineButton extends StatelessWidget {
  const DeclineButton({this.returnValue = false, this.text = "No", super.key});

  final dynamic returnValue;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return DialogActionButton(
      onTap: () => Navigator.maybePop(context, returnValue),
      icon: const Icon(CustomIcons.cancel),
      text: text,
      color: context.colors.negative,
    );
  }
}
