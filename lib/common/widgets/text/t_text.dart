import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class TText extends StatelessWidget {
  const TText(this.message, {this.icon, this.color, this.style, super.key});

  final String message;
  final IconData? icon;
  final Color? color;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    Color color = this.color ?? context.colors.onBackground;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, color: color),
          const Margin.horizontal(ThemeConstants.spacing),
        ],
        Expanded(
          child: Text(
            message,
            style: (style ?? context.textTheme.labelLarge).withColor(color),
          ),
        ),
      ],
    );
  }
}
