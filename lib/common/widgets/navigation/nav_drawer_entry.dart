import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class NavDrawerEntry extends StatelessWidget {
  const NavDrawerEntry({
    required this.title,
    required this.icon,
    required this.buildDestination,
    super.key,
  });

  final String title;
  final IconData icon;
  final Widget Function(BuildContext context) buildDestination;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () {
        context.navigator.popUntil((_) => false);
        context.navigator.navigateTo(buildDestination(context));
      },
    );
  }
}
