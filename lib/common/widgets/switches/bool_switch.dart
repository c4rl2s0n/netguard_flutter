import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class BoolSwitch extends StatelessWidget {
  const BoolSwitch({
    required this.textLeft,
    required this.textRight,
    this.rightSelected = false,
    this.onChanged,
    super.key,
  });

  final String textLeft;
  final String textRight;
  final bool rightSelected;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          [
            Text(textLeft),
            Switch(value: rightSelected, onChanged: onChanged),
            Text(textRight),
          ].insertBetweenItems(
            () => const Margin.horizontal(ThemeConstants.spacing),
          ),
    );
  }
}
