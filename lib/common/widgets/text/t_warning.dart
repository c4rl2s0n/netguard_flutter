import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

import 't_text.dart';

class TWarning extends StatelessWidget {
  const TWarning(this.message, {this.style, super.key});

  final String message;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    Color color = context.colors.warning;
    return TText(
      message,
      icon: CustomIcons.warning,
      color: style?.color ?? color,
      style: style,
    );
  }
}
