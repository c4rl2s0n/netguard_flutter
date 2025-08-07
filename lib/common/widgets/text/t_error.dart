import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

import 't_text.dart';

class TError extends StatelessWidget {
  const TError(this.message, {this.style, super.key});

  final String message;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    Color color = context.colors.error;
    return TText(
      message,
      icon: CustomIcons.error,
      color: style?.color ?? color,
      style: style,
    );
  }
}
