import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

typedef ExpanderWidgetBuilder =
    Widget Function(BuildContext context, bool isExpanded);
typedef ExpanderOptionalWidgetBuilder =
    Widget? Function(BuildContext context, bool isExpanded);

class Expander extends StatefulWidget {
  const Expander({
    required this.buildTitle,
    this.buildSubtitle,
    this.leadingIcon,
    this.color,
    this.buildTrailing,
    required this.children,
    super.key,
  });

  final ExpanderWidgetBuilder buildTitle;
  final ExpanderOptionalWidgetBuilder? buildSubtitle;
  final IconData? leadingIcon;
  final List<Widget> children;
  final Color? color;
  final ExpanderWidgetBuilder? buildTrailing;

  @override
  State<Expander> createState() => _ExpanderState();
}

class _ExpanderState extends State<Expander> {
  late ExpansibleController expansibleController;
  bool get isExpanded => expansibleController.isExpanded;

  @override
  void initState() {
    expansibleController = ExpansibleController();
    expansibleController.addListener(onExpansionChange);
    super.initState();
  }

  @override
  void dispose() {
    expansibleController.removeListener(onExpansionChange);
    super.dispose();
  }

  void onExpansionChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Color color = widget.color ?? context.colors.tertiaryContainer;
    return Theme(
      data: context.themeData.copyWith(hoverColor: color),
      child: ExpansionTile(
        controller: expansibleController,
        title: _title(context), //widget.buildTitle(context, isExpanded),
        subtitle: _subtitle(
          context,
        ), //widget.buildSubtitle?.call(context, isExpanded),
        leading: widget.leadingIcon != null ? Icon(widget.leadingIcon) : null,
        trailing: widget.buildTrailing?.call(context, isExpanded),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color, width: 2),
          borderRadius: ThemeConstants.borderRadius,
        ),
        collapsedShape: const RoundedRectangleBorder(
          side: BorderSide(width: 0),
          borderRadius: ThemeConstants.borderRadius,
        ),
        tilePadding: const EdgeInsets.symmetric(
          horizontal: ThemeConstants.spacing,
        ),
        childrenPadding: const EdgeInsets.only(
          left: ThemeConstants.spacing,
          right: ThemeConstants.spacing,
          bottom: ThemeConstants.spacing,
        ),
        children: widget.children,
      ),
    );
  }

  Widget _title(BuildContext context) => DefaultTextStyle(
    style:
        context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold) ??
        const TextStyle(),
    child: widget.buildTitle(context, isExpanded),
  );

  Widget? _subtitle(BuildContext context) {
    Widget? subtitle = widget.buildSubtitle?.call(context, isExpanded);
    if (subtitle == null) return null;
    return DefaultTextStyle(
      style:
          context.textTheme.labelMedium.withOpacity(
            ThemeConstants.lightColorOpacity,
          ) ??
          const TextStyle(),
      child: subtitle,
    );
  }
}
