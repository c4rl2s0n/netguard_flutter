import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class TapContainer extends StatelessWidget {
  const TapContainer({
    this.onTap,
    this.onSecondaryTap,
    this.child,
    this.enabled = true,
    this.backgroundColor,
    this.splashColor,
    this.padding,
    super.key,
  });

  final Widget? child;
  final Function(Offset? position)? onTap;
  final Function(Offset? position)? onSecondaryTap;
  final bool enabled;
  final Color? backgroundColor;
  final Color? splashColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    Offset? pointerPosition;
    return Listener(
      onPointerDown: (d) => pointerPosition = d.position,
      child: Material(
        color: !enabled
            ? context.colors.disabledContainer
            : backgroundColor ?? Colors.transparent,
        borderRadius: const BorderRadius.all(
          ThemeConstants.roundedCornerRadius,
        ),
        child: InkWell(
          canRequestFocus: false,
          borderRadius: const BorderRadius.all(
            ThemeConstants.roundedCornerRadius,
          ),
          splashColor: splashColor ?? context.colors.secondary,
          highlightColor: context.colors.tertiary,
          hoverColor: context.colors.onBackground.withOpacity(
            ThemeConstants.strongColorOpacity,
          ),
          splashFactory: InkRipple.splashFactory,
          onTap: onTap != null && enabled
              ? () => performDelayedTap(context, () => onTap!(pointerPosition))
              : null,
          onSecondaryTap: onSecondaryTap != null && enabled
              ? () => performDelayedTap(
                  context,
                  () => onSecondaryTap!(pointerPosition),
                )
              : null,
          child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
        ),
      ),
    );
  }
}
