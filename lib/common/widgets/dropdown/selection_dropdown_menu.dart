import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class SelectionDropdownMenu<T> extends StatefulWidget {
  const SelectionDropdownMenu({
    required this.options,
    this.initialSelection = const [],
    this.buildOption,
    this.onToggleSelection,
    this.onSelectionChanged,
    this.optionToString,
    this.emptyText = "Select items",
    this.multiSelectionSuffix = "selected",
    super.key,
  });

  final List<T> options;
  final List<T> initialSelection;
  final Widget Function(BuildContext context, T option, bool selected)?
  buildOption;
  final void Function(T option, bool selected)? onToggleSelection;
  final void Function(List<T> selection)? onSelectionChanged;
  final String Function(T)? optionToString;

  final String emptyText;
  final String multiSelectionSuffix;

  @override
  State<SelectionDropdownMenu<T>> createState() =>
      _SelectionDropdownMenuState();
}

class _SelectionDropdownMenuState<T> extends State<SelectionDropdownMenu<T>> {
  Set<T> selected = Set.from([]); // Set to hold selected items

  String optionToString(T option) => widget.optionToString != null
      ? widget.optionToString!(option)
      : option.toString();

  Widget buildOption(BuildContext context, T option, bool selected) =>
      widget.buildOption != null
      ? widget.buildOption!(context, option, selected)
      : _defaultOption(context, option, selected);

  @override
  void initState() {
    selected.addAll(widget.initialSelection);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SelectionDropdownMenu<T> oldWidget) {
    if (!oldWidget.initialSelection.equals(widget.initialSelection)) {
      selected = Set.from(widget.initialSelection);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color:
                context
                    .themeData
                    .dropdownMenuTheme
                    .inputDecorationTheme
                    ?.border
                    ?.borderSide
                    .color ??
                Colors.transparent,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(child: _text(context)),
          _dropdown(),
        ],
      ),
    );
    //return Row(children: [Expanded(child: _text()), _dropdown()]);
  }

  Widget _text(BuildContext context) {
    return Text(
      selected.isEmpty
          ? widget.emptyText
          : selected.length == 1
          ? optionToString(selected.first)
          : "${(selected.length)} ${widget.multiSelectionSuffix}",
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.labelMedium,
    );
  }

  Widget _dropdown() {
    return PopupMenuButton(
      icon: Icon(Icons.arrow_drop_down),
      onCanceled: () => widget.onSelectionChanged?.call(selected.toList()),
      itemBuilder: (context) => widget.options.map((e) {
        return PopupMenuItem(
          enabled: false,
          value: e,
          textStyle: context.textTheme.labelLarge.withColor(Colors.white),
          child: StatefulBuilder(
            builder: (context, _setState) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onLongPress: () {
                // reset selection on longPress
                selected.clear();
                widget.onToggleSelection?.call(e, false);
                //widget.onSelectionChanged?.call(selected.toList());
                context.navigator.pop();
              },
              onTap: () {
                // toggle selection onTap
                bool isSelected = selected.contains(e);
                if (isSelected) {
                  selected.remove(e); // Remove item if deselected
                } else {
                  selected.add(e); // Add item if selected
                }
                widget.onToggleSelection?.call(e, !isSelected);
                //widget.onSelectionChanged?.call(selected.toList());
                _setState(() {});
                setState(() {});
              },
              child: buildOption(context, e, selected.contains(e)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _defaultOption(BuildContext context, T option, bool selected) => Row(
    children: [
      // Checkbox to select/deselect items
      Checkbox(
        value: selected,
        onChanged: (isSelected) {
          if (isSelected == true) {
            this.selected.add(option); // Add item if selected
          } else {
            this.selected.remove(option); // Remove item if deselected
          }
          setState(() {});
        },
      ),
      const Margin.horizontal(ThemeConstants.spacing),
      Text(
        optionToString(option),
        style: context.textTheme.labelMedium.withColor(
          context.colors.onSurface,
        ),
      ), // Display item label
    ],
  );
}
