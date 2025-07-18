import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    this.title,
    required this.child,
    this.width,
    this.height,
    this.headerTextStyle,
    this.headerHeight = 30,
    this.scrollable,
    this.action,
    super.key,
  });

  final String? title;
  final Widget child;
  final double? width;
  final double? height;
  final TextStyle? headerTextStyle;
  final double? headerHeight;
  final bool? scrollable;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null && title!.isNotEmpty || action != null) ...[
          _headerRow(context),
        ],
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(ThemeConstants.spacing),
            height: height,
            width: width,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: context.colors.primaryContainer,
              ),
              borderRadius: ThemeConstants.borderRadius,
            ),
            child: _buildChild(),
          ),
        ),
      ].insertBetweenItems(() => const Margin.vertical(ThemeConstants.spacing)),
    );
  }

  Widget _headerRow(BuildContext context) {
    return SizedBox(
      height: headerHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null && title!.isNotEmpty) ...[
            Text(
              title!,
              style: headerTextStyle ?? context.textTheme.titleLarge,
            ),
          ],
          if (action != null) ...[action!],
        ],
      ),
    );
  }

  Widget _buildChild() {
    Widget c = child;
    if (scrollable == true) {
      c = ScrollContainer(
        scrollbarOrientation: ScrollbarOrientation.right,
        scrollDirection: Axis.vertical,
        child: c,
      );
    }
    return c;
  }
}
