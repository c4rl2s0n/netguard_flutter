import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

class SortingSetting extends StatelessWidget {
  const SortingSetting({
    required this.selected,
    required this.options,
    required this.onChanged,
    this.enabled = true,
    super.key,
  });

  final LogSorting selected;
  final List<LogSorting> options;
  final Function(LogSorting) onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SimpleSetting(
      name: "Sorting",
      description: "How to sort data",
      enabled: enabled,
      action: DropdownMenu<LogSorting>(
        enabled: enabled,
        initialSelection: selected,
        requestFocusOnTap: false,
        onSelected: (v) => v != null ? onChanged(v) : null,
        dropdownMenuEntries: options
            .map(
              (d) =>
                  DropdownMenuEntry<LogSorting>(value: d, label: d.toString()),
            )
            .toList(),
      ),
    );
  }
}
