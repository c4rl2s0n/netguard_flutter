import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class SwitchSetting extends StatelessWidget {
  const SwitchSetting({
    required this.name,
    required this.value,
    this.description,
    this.leading,
    this.onChanged,
    this.warning,
    super.key,
  });

  final String name;
  final String? description;
  final Widget? leading;
  final bool value;
  final Function(bool)? onChanged;
  final String? warning;
  @override
  Widget build(BuildContext context) {
    return ActionSetting(
      name: name,
      description: description,
      leading: leading,
      trailing: Switch(value: value, onChanged: onChanged),
      action: onChanged != null ? (_) => onChanged?.call(!value) : null,
    );
  }
}
