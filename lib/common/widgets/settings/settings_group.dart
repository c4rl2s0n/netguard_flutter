import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({
    required this.title,
    required this.settings,
    this.info,
    this.action,
    super.key,
  });

  final String title;
  final Widget? info;
  final Widget? action;
  final List<Widget> settings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: context.textTheme.headlineMedium),
            if (action != null) action!,
          ],
        ),
        if(info != null) info!,
        const Margin.vertical(ThemeConstants.largeSpacing),
        ...settings.insertBetweenItems(
          () => const Margin.vertical(ThemeConstants.spacing),
        ),
      ],
    );
  }
}
