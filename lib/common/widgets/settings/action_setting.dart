import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class ActionSetting extends StatelessWidget {
  const ActionSetting({
    required this.name,
    this.description,
    this.leading,
    this.trailing,
    required this.action,
    super.key,
  });

  final String name;
  final String? description;
  final Widget? leading;
  final Widget? trailing;
  final Function(BuildContext context)? action;

  @override
  Widget build(BuildContext context) {
    bool enabled = action != null;
    TextStyle titleStyle = context.textTheme.titleMedium ?? const TextStyle();
    TextStyle descriptionStyle =
        context.textTheme.labelMedium ?? const TextStyle();
    if (!enabled) {
      titleStyle = titleStyle.withColor(context.colors.disabledContent)!;
      descriptionStyle = descriptionStyle.withColor(context.colors.disabledContent)!;
    }
    return TapContainer(
      enabled: enabled,
      padding: EdgeInsets.all(ThemeConstants.smallSpacing),
      onTap: (_) => action?.call(context),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leading != null) ...[
            leading!,
            const Margin.horizontal(ThemeConstants.smallSpacing),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: titleStyle),
                if (description != null) ...[
                  Text(description!, style: descriptionStyle),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
