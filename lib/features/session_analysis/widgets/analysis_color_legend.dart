import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

class AnalysisColorLegend extends StatelessWidget {
  const AnalysisColorLegend(this.entries, {super.key});

  factory AnalysisColorLegend.colorOnly(BuildContext context) =>
      AnalysisColorLegend([
        LegendEntry(color: context.colors.positive, label: "Allowed"),
        LegendEntry(color: context.colors.negative, label: "Blocked"),
      ]);

  final List<LegendEntry> entries;

  @override
  Widget build(BuildContext context) {
    int split = (entries.length / 2).toInt();
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: entries.sublist(0, split),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: entries.sublist(split),
          ),
        ),
      ],
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.largeSpacing,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: entries
      ),
    );
  }
}

class LegendEntry extends StatelessWidget {
  const LegendEntry({
    required this.label,
    required this.color,
    this.icon,
    this.indicatorSize = 12,
    super.key,
  });

  final String label;
  final Color color;
  final IconData? icon;

  final double indicatorSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon == null) ...[
          Container(
            width: indicatorSize,
            height: indicatorSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(indicatorSize),
              color: color,
            ),
          ),
        ] else ...[
          Icon(icon, size: indicatorSize, color: color),
        ],
        const Margin.horizontal(ThemeConstants.spacing),
        Text(label),
      ],
    );
  }
}
