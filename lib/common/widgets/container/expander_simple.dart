import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class ExpanderSimple extends StatelessWidget {
  const ExpanderSimple({
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.color,
    required this.children,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final List<Widget> children;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expander(
      buildTitle: (context, _) => Text(title), //_title(context),
      buildSubtitle: (_, __) => subtitle.notEmpty ? Text(subtitle!) : null,
      leadingIcon: leadingIcon,
      color: color,
      children: children,
    );
  }
}
