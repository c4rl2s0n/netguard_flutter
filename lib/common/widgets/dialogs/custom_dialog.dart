import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

class CustomDialog<T> extends StatelessWidget {
  const CustomDialog({
    required this.title,
    required this.content,
    this.titleTrailing,
    this.icon,
    this.actions,
    this.expand = true,
    super.key,
  });

  final String title;
  final Widget? titleTrailing;
  final Widget content;
  final Widget? icon;
  final List<Widget>? actions;
  final bool expand;

  final double maxTitleWidgetHeight = 28;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      contextMenuBuilder: (_, __) => const SizedBox.shrink(),
      child: AlertDialog(
        backgroundColor: context.colors.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: context.colors.primary, width: 2),
          borderRadius: ThemeConstants.borderRadius,
        ),
        insetPadding: const EdgeInsets.all(ThemeConstants.spacing),
        contentPadding: const EdgeInsets.all(ThemeConstants.spacing),
        content: Builder(
          builder: (context) {
            MediaQueryData mediaQuery = MediaQuery.of(context);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle(context),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(ThemeConstants.smallSpacing),
                  child: expand
                      ? Expanded(child: content)
                      : Container(
                          constraints: BoxConstraints(
                            maxHeight: mediaQuery.size.height * 0.6,
                          ),
                          child: content,
                        ),
                ),
                if (actions != null) ..._buildActions(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    Widget icon = this.icon ?? const Icon(CustomIcons.loading);
    TextStyle titleTextStyle =
        context.textTheme.headlineSmall ?? const TextStyle();
    double titleWidgetHeight =
        (titleTextStyle.fontSize ?? maxTitleWidgetHeight) *
        (titleTextStyle.height ?? 1);
    return IconTheme(
      data: context.iconTheme.copyWith(size: titleWidgetHeight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const Margin.horizontal(ThemeConstants.spacing),
          Text(title, style: titleTextStyle, softWrap: true, maxLines: 2),
          if (titleTrailing != null) ...[
            const Margin.horizontal(ThemeConstants.spacing),
            SizedBox(height: titleWidgetHeight, child: titleTrailing!),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    assert(actions != null);
    return [
      const Divider(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: actions!),
    ];
  }
}
