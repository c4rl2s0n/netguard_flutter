import 'dart:math';

import 'package:fl_chart/fl_chart.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

class PieChart extends StatelessWidget {
  const PieChart(this.analysis, {required this.size, super.key});

  final TrafficLogAggregation analysis;
  final Size size;

  bool get isApp => analysis is TrafficLogByApplication;

  final double centerRadiusApp = 20;
  final double centerRadiusDefault = 5;
  double get centerRadius => isApp ? centerRadiusApp : centerRadiusDefault;

  @override
  Widget build(BuildContext context) {
    return _forApplication(
      (byApp, child) =>
          TapToAppLogs(application: byApp.application, child: child),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _chart(),
          const Margin.vertical(ThemeConstants.smallSpacing),
          _label(context),
          _totalVolumeLabel(),
        ],
      ),
    );
  }

  Widget _label(BuildContext context) => Text(
    // replace '-' to avoid inefficient linebreaks for URLs
    analysis.label.replaceAll("-", "\u2011"),
    style: context.textTheme.labelLarge,
    textAlign: TextAlign.center,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );

  Widget _totalVolumeLabel() =>
      BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
          buildWhen: (oldState, state) =>
          oldState.volumeType != state.volumeType,
          builder: (context, state) =>Text(
            switch(state.volumeType){
              VolumeType.count => analysis.count.toString(),
              VolumeType.bytes => analysis.size.readableFileSize(),
            },
            style: context.textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),);

  Widget _chart() {
    return SizedBox.square(
      dimension: size.width,
      child: Stack(
        children: [
          BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
            buildWhen: (oldState, state) =>
                oldState.volumeType != state.volumeType,
            builder: (context, state) => charts.PieChart(
              charts.PieChartData(
                borderData: charts.FlBorderData(show: false),
                startDegreeOffset: -90,
                sections: _sections(
                  context,
                  size.width,
                  state.volumeType,
                ),
                centerSpaceRadius: centerRadius,
              ),
            ),
          ),
          _forApplication(
            (byApp, child) => Center(
              child: SizedBox.square(
                dimension: centerRadiusApp * 2 - 5,
                child: byApp.application?.image ?? Icon(CustomIcons.question),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _forApplication(
    Widget Function(TrafficLogByApplication byApp, Widget child) build, {
    Widget? child,
  }) => Optional(
    buildOptional: (child) => build(analysis as TrafficLogByApplication, child),
    useOptional: isApp,
    child: child ?? SizedBox.shrink(),
  );

  double _getSize(BoxConstraints constraints) {
    double size = 0;
    if (constraints.hasBoundedHeight && constraints.hasBoundedWidth) {
      size = min(constraints.maxHeight, constraints.maxWidth);
    } else if (constraints.hasBoundedHeight) {
      size = constraints.maxHeight;
    } else if (constraints.hasBoundedWidth) {
      size = constraints.maxWidth;
    }
    return max(0, size);
  }

  List<charts.PieChartSectionData> _sections(
    BuildContext context,
    double size,
    VolumeType type,
  ) {
    size = size - centerRadius * 2;
    TextStyle textStyle = context.textTheme.labelLarge!.copyWith(
      fontWeight: FontWeight.bold,
    );
    double valueAllowed = switch (type) {
      VolumeType.count => analysis.countAllowed.toDouble(),
      VolumeType.bytes => analysis.sizeAllowed.toDouble(),
    };
    double valueBlocked = switch (type) {
      VolumeType.count => analysis.countBlocked.toDouble(),
      VolumeType.bytes => analysis.sizeBlocked.toDouble(),
    };
    String titleAllowed = switch (type) {
      VolumeType.count => valueAllowed.toInt().toString(),
      VolumeType.bytes => valueAllowed.readableFileSize(base1024: false),
    };
    String titleBlocked = switch (type) {
      VolumeType.count => valueBlocked.toInt().toString(),
      VolumeType.bytes => valueBlocked.readableFileSize(base1024: false),
    };
    return [
      charts.PieChartSectionData(
        color: context.colors.positive,
        radius: size / 2,
        value: valueAllowed,
        title: titleAllowed,
        titleStyle: textStyle.withColor(context.colors.onPositive),
      ),
      charts.PieChartSectionData(
        color: context.colors.negative,
        radius: size / 2,
        value: valueBlocked,
        title: titleBlocked,
        titleStyle: textStyle.withColor(context.colors.onNegative),
      ),
    ];
  }
}
