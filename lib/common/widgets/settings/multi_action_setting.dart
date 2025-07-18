import 'package:flutter/material.dart';

import 'simple_setting.dart';

class MultiActionSetting extends StatelessWidget {
  const MultiActionSetting({
    required this.name,
    this.description,
    this.actions,
    this.warning,
    super.key,
  });

  final String name;
  final String? description;
  final List<Widget>? actions;
  final String? warning;
  @override
  Widget build(BuildContext context) {
    return SimpleSetting(
      name: name,
      description: description,
      warning: warning,
      action: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions ?? [],
      ),
    );
  }
}
