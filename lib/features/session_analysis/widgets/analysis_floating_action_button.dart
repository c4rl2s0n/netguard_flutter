import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class AnalysisFloatingActionButton extends StatelessWidget {
  const AnalysisFloatingActionButton({
    required this.child,
    this.onPressed,
    super.key,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: context.colors.secondaryContainer,
      foregroundColor: context.colors.onSecondaryContainer,
      shape: CircleBorder(),
      onPressed: onPressed,
      child: child,
    );
  }
}
