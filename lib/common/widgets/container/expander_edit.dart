import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class ExpanderEdit extends StatelessWidget {
  const ExpanderEdit({
    required this.title,
    this.subtitle,
    this.buildLeading,
    this.color,
    this.trailing,
    required this.child,
    this.onTitleChanged,
    this.showSubtitleOnEdit = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final ExpanderOptionalWidgetBuilder? buildLeading;
  final Widget child;
  final Widget? trailing;
  final Color? color;
  final Function(String)? onTitleChanged;
  final bool showSubtitleOnEdit;

  @override
  Widget build(BuildContext context) {
    return Expander(
      buildTitle: _title,
      buildSubtitle: _subtitle,
      buildLeading: buildLeading,
      buildTrailing: (context, isExpanded) =>
          trailing ?? Icon(isExpanded ? CustomIcons.edit : CustomIcons.editOff),
      color: color,
      children: [child],
    );
  }

  Widget _title(BuildContext context, bool isExpanded) => isExpanded
      ? SimpleTextField(initialValue: title, onChanged: onTitleChanged)
      : Text(title);

  Widget? _subtitle(BuildContext context, bool isExpanded) =>
      subtitle.notEmpty && (showSubtitleOnEdit || !isExpanded)
      ? Text(subtitle!)
      : null;
}
