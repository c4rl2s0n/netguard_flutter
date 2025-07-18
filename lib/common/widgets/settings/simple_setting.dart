import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class SimpleSetting extends StatelessWidget {
  const SimpleSetting({
    required this.name,
    this.description,
    this.action,
    this.warning,
    super.key,
  });

  final String name;
  final String? description;
  final Widget? action;
  final String? warning;
  @override
  Widget build(BuildContext context) {
    bool showWarning = warning.notEmpty;
    TextStyle titleStyle = context.textTheme.titleMedium ?? const TextStyle();
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: titleStyle.copyWith(
                      color: showWarning ? context.colors.warning : null,
                    ),
                  ),
                  if (showWarning) ...[
                    const Margin.horizontal(ThemeConstants.spacing),
                    Tooltip(
                      message: warning,
                      child: Icon(
                        CustomIcons.warning,
                        color: context.colors.warning,
                        size: titleStyle.fontSize,
                      ),
                    ),
                  ],
                ],
              ),
              if (description != null) ...[
                Text(description!, style: context.textTheme.labelMedium),
              ],
            ],
          ),
        ),
        if (action != null) ...[Flexible(flex: 1, child: action!)],
      ],
    );
  }
}
