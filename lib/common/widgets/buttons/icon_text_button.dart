import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    this.icon,
    this.text,
    this.textStyle,
    this.enabled = true,
    this.onTap,
    this.loading = false,
    this.color,
    this.verticalPadding,
    this.horizontalPadding,
    super.key,
  });

  final Icon? icon;
  final String? text;
  final TextStyle? textStyle;
  final bool enabled;
  final Function()? onTap;
  final bool loading;
  final Color? color;
  final double? verticalPadding;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    bool disabled = onTap == null || !enabled;
    Color color = disabled
        ? context.colors.disabledContainer
        : this.color ?? context.colors.primary;
    TextStyle? usedTextStyle = textStyle ?? context.textTheme.labelMedium;
    if (disabled) {
      usedTextStyle = usedTextStyle?.copyWith(
        color: context.colors.disabledContent,
      );
    }
    return TapContainer(
      onTap: onTap != null && enabled ? (_) => onTap!() : null,
      splashColor: color.withOpacity(ThemeConstants.strongColorOpacity),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? ThemeConstants.largeSpacing,
          vertical: verticalPadding ?? ThemeConstants.smallSpacing,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            ThemeConstants.roundedCornerRadius,
          ),
          border: Border.all(color: color, width: 2),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading) ...[
              CircularProgressIndicator(color: color),
            ] else if (icon != null) ...[
              IconTheme(
                data: context.iconTheme.copyWith(color: color),
                child: icon!,
              ),
            ],
            if (icon != null && text != null) ...[
              const SizedBox(width: ThemeConstants.spacing),
            ],
            if (text != null) ...[Text(text!, style: usedTextStyle)],
          ],
        ),
      ),
    );
  }
}
