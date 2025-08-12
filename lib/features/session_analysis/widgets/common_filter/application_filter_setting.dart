import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

class ApplicationFilterSetting extends StatelessWidget {
  const ApplicationFilterSetting({
    this.initialSelection = const [],
    this.onSelectionChanged,
    super.key,
  });

  final List<Application?> initialSelection;
  final Function(List<Application?>)? onSelectionChanged;
  @override
  Widget build(BuildContext context) {
    return SimpleSetting(
        name: "Application filter",
        description: "Show only the selected application",
        action: ApplicationSelectionDropdownMenu(
          initialSelection: initialSelection,
          onSelectionChanged: onSelectionChanged,
          onlyObserved: true,
        )
    );
  }
}
