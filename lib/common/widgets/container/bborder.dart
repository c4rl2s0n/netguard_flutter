import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class BBorder extends StatelessWidget {
  const BBorder({this.width = 2, this.color, this.padding, required this.child, super.key});

  final double width;
  final Color? color;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: ThemeConstants.borderRadius,
        border: Border.all(
          color: color ?? context.colors.primary,
          width: width,
        ),
      ),
      padding: padding ?? const EdgeInsets.all(ThemeConstants.spacing),
      child: child,
    );
  }
}

extension BorderExtension on Widget {
  Widget withBorder({double width = 2, Color? color, EdgeInsets? padding}) =>
      BBorder(width: width, color: color, padding: padding, child: this);
}
