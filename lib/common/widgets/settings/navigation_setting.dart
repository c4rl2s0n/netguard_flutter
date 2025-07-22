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
    return ActionSetting(
      name: name,
      description: description,
      trailing: Icon(Icons.chevron_right),
      action: (context) =>
          context.navigator.navigateTo(getDestination(context)),
    );
  }
}
