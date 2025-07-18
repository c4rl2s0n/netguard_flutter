import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class DropDownMenuFactory {
  static DropdownMenuEntry<T> dropdownMenuEntry<T>(
    BuildContext context, {
    required T value,
    required String label,
  }) {
    return DropdownMenuEntry<T>(
      value: value,
      label: label,
      labelWidget: Text(label, style: context.textTheme.labelLarge),
    );
  }
}
