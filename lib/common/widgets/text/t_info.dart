import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

import 't_text.dart';

class TInfo extends StatelessWidget {
  const TInfo(this.message, {this.style, super.key});

  final String message;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    Color color = context.colors.tertiary;
    return TText(
      message,
      icon: CustomIcons.info,
      color: style?.color ?? color,
      style: style,
    );
  }
}
