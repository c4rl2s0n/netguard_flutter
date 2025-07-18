import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class NavigationSetting extends StatelessWidget {
  const NavigationSetting({
    required this.name,
    this.description,
    required this.getDestination,
    super.key,
  });

  final String name;
  final String? description;
  final Widget Function(BuildContext context) getDestination;

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = context.textTheme.titleMedium ?? const TextStyle();
    return TapContainer(
      onTap: (_) => context.navigator.navigateTo(getDestination(context)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: titleStyle),
                if (description != null) ...[
                  Text(description!, style: context.textTheme.labelMedium),
                ],
              ],
            ),
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
