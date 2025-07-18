import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({this.returnValue = true, this.text = "Okay", super.key});

  final dynamic returnValue;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return DialogActionButton(
      onTap: () => Navigator.maybePop(context, returnValue),
      icon: const Icon(CustomIcons.check),
      text: text,
      color: context.colors.positive,
    );
  }
}
