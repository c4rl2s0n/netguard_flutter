import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

class ApplicationSelectionDropdownMenu extends StatelessWidget {
  const ApplicationSelectionDropdownMenu({
    this.initialSelection = const [],
    this.onSelectionChanged,
    this.onToggleSelection,
    super.key,
  });

  final List<Application?> initialSelection;
  final Function(Application? app, bool selected)? onToggleSelection;
  final Function(List<Application?>)? onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return SelectionDropdownMenu(
      options: <Application?>[
        null,
        ...sessionCubit.state.applications,
      ].where((a) => a == null || (a.setting?.filter ?? false)).toList(),
      initialSelection: initialSelection,
      onSelectionChanged: onSelectionChanged,
      onToggleSelection: onToggleSelection,
      optionToString: (a) => a.label,
      buildOption: _buildOption,
      emptyText: "All",
      multiSelectionSuffix: "apps",
    );
  }

  Widget _buildOption(BuildContext context, Application? app, bool selected) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? context.colors.positive : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: SizedBox.square(
            dimension: 24,
            child: app?.image ?? Icon(CustomIcons.question),
          ),
        ),
        const Margin.horizontal(ThemeConstants.smallSpacing),
        Text(
          app.label,
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: selected ? FontWeight.bold : null,
            decoration: selected ? TextDecoration.underline : null,
          ),
        ),
      ],
    );
  }
}
