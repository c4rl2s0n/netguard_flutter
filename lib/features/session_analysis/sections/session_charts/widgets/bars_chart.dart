import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/features/features.dart';

class BarsChart<T extends TrafficLogAggregation> extends StatelessWidget {
  const BarsChart(this.analysis, {super.key});

  final List<T> analysis;

  bool get isApp => T == TrafficLogByApplication;

  final double barWidth = 5;
  final double entryHeight = 60;
  final int volumeIndicationSteps = 5;
  double get labelSpace => isApp ? 42 : 155;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: LayoutBuilder(
        builder: (context, constraints) => Optional(
          useOptional: !isApp,
          buildOptional: (child) => OverflowBox(
            fit: OverflowBoxFit.deferToChild,
            maxWidth: constraints.maxWidth + labelSpace,
            maxHeight: analysis.length * entryHeight,
            child: Transform.translate(
              offset: Offset(-labelSpace / 2 + 1, 0),
              child: Row(mainAxisSize: MainAxisSize.min, children: [child]),
            ),
          ),
          child: SizedBox(
            height: analysis.length * entryHeight,
            width: isApp
                ? constraints.maxWidth
                : constraints.maxWidth + labelSpace,
            child: _barChart(),
          ),
        ),
      ),
    );
  }

  // TODO: when scrolling, the traffic volume disappears...
  // Widget _fixIndicator() {
  //   return BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
  //     buildWhen: (oldState, state) => oldState.volumeType != state.volumeType,
  //     builder: (context, analysisState) =>
  //         BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
  //           buildWhen: (oldState, state) =>
  //               oldState.singleBar != state.singleBar ||
  //               oldState.groupType != state.groupType,
  //           builder: (context, state) => LayoutBuilder(
  //             builder: (context, constraints) {
  //               double intervalWidth =
  //                   (constraints.maxWidth - labelSpace) / (volumeIndicationSteps);
  //               double intervalStep = _getVolumeIndicationInterval(
  //                 analysisState.volumeType,
  //                 state,
  //               );
  //               return SizedBox(
  //                 width: constraints.maxWidth,
  //                 child: Row(
  //                   children:[
  //                       if(state.groupType == GroupType.destination) SizedBox(width: labelSpace,),
  //                       ...List.generate(
  //                             volumeIndicationSteps + 1,
  //                             (i) => SizedBox(
  //                               width: intervalWidth,
  //                               child: Text(switch (state.groupType) {
  //                                 GroupType.application => (i * intervalStep).toInt().toString(),
  //                                 GroupType.destination => (i * intervalStep).readableFileSize(),
  //                               }),
  //                             ),
  //                           )
  //                           as List<Widget>,
  //               ],
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //   );
  // }

  Widget _barChart() =>
      BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
        buildWhen: (oldState, state) => oldState.volumeType != state.volumeType,
        builder: (context, analysisState) =>
            BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
              buildWhen: (oldState, state) =>
                  oldState.singleBar != state.singleBar,
              builder: (context, filter) => BarChart(
                BarChartData(
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(
                        color: context.colors.onSurface.light,
                        width: 2,
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipPadding: const EdgeInsets.symmetric(horizontal: 8),
                        //tooltipMargin: -20,
                        tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                        //tooltipHorizontalOffset: -15,
                        fitInsideHorizontally: true,
                        fitInsideVertically: true,
                        tooltipBorder: BorderSide(color: context.colors.onSurface),
                        tooltipBorderRadius: ThemeConstants.borderRadius,
                        getTooltipColor: (data) => context.colors.surfaceContainer,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            switch(analysisState.volumeType){
                              VolumeType.count => rod.toY.toInt().toString(),
                              VolumeType.bytes => rod.toY.readableFileSize(),
                            },
                            TextStyle(
                              color: context.colors.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      touchCallback: (event, response) {
                        // Optional: handle interaction
                      },

                  ),
                  rotationQuarterTurns: 1,
                  titlesData: _axisDescription(
                    context,
                    analysisState.volumeType,
                    filter,
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: context.colors.onSurface.light,
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: _bars(
                    context,
                    filter.singleBar,
                    analysisState.volumeType,
                  ),
                ),
              ),
            ),
      );

  FlTitlesData _axisDescription(
    BuildContext context,
    VolumeType volumeType,
    SessionChartFilterState filter,
  ) => FlTitlesData(
    show: true,
    leftTitles: _volumeIndicator(volumeType, filter),
    bottomTitles: _groupIndicator(context),
    rightTitles: _volumeIndicator(volumeType, filter), //const AxisTitles(),
    topTitles: const AxisTitles(),
  );
  AxisTitles _volumeIndicator(
    VolumeType volumeType,
    SessionChartFilterState filter,
  ) => AxisTitles(
    drawBelowEverything: true,
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 25,
      interval: _getVolumeIndicationInterval(volumeType, filter),
      getTitlesWidget: (v, meta) => SideTitleWidget(
        meta: meta,
        child: Transform.translate(
          offset: Offset(0, 0),
          child: Text(switch (volumeType) {
            VolumeType.count => v.toInt().toString(),
            VolumeType.bytes => v.readableFileSize(),
          }),
        ),
      ),
    ),
  );
  AxisTitles _groupIndicator(BuildContext context) => AxisTitles(
    drawBelowEverything: false,
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: labelSpace,
      getTitlesWidget: (value, meta) {
        final index = value.toInt();
        T current = analysis[index];
        return SideTitleWidget(
          meta: meta,
          fitInside: SideTitleFitInsideData.disable(),
          child: current is TrafficLogByApplication
              ? TapToAppLogs(
                  application: current.application,
                  child: Center(child: current.application.image),
                )
              : Transform.translate(
                  offset: Offset(labelSpace + 10, -20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      analysis.elementAt(index).label,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
        );
      },
    ),
  );

  List<BarChartGroupData> _bars(
    BuildContext context,
    bool singleBar,
    VolumeType type,
  ) {
    return List.generate(analysis.length, (i) {
      TrafficLogAggregation current = analysis.elementAt(i);
      TextStyle textStyle = context.textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.bold,
      );
      double valueAllowed = switch (type) {
        VolumeType.count => current.countAllowed.toDouble(),
        VolumeType.bytes => current.sizeAllowed.toDouble(),
      };
      double valueBlocked = switch (type) {
        VolumeType.count => current.countBlocked.toDouble(),
        VolumeType.bytes => current.sizeBlocked.toDouble(),
      };
      String titleAllowed = switch (type) {
        VolumeType.count => valueAllowed.toInt().toString(),
        VolumeType.bytes => valueAllowed.readableFileSize(base1024: false),
      };
      String titleBlocked = switch (type) {
        VolumeType.count => valueBlocked.toInt().toString(),
        VolumeType.bytes => valueBlocked.readableFileSize(base1024: false),
      };
      return BarChartGroupData(
        x: i,
        barRods: singleBar
            ? [
                BarChartRodData(
                  toY: valueAllowed + valueBlocked,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      context.colors.positive,
                      context.colors.positive,
                      context.colors.negative,
                      context.colors.negative,
                    ],
                    stops: [
                      0,
                      valueAllowed / (valueAllowed + valueBlocked),
                      valueAllowed / (valueAllowed + valueBlocked),
                      1,
                    ],
                  ),
                  width: 2 * barWidth,
                ),
              ]
            : [
                BarChartRodData(
                  toY: valueAllowed,
                  color: context.colors.positive,
                  width: barWidth,
                ),
                BarChartRodData(
                  toY: valueBlocked,
                  color: context.colors.negative,
                  width: barWidth,
                ),
              ],
      );
    });
  }

  /// COMPUTATIONS

  double _getVolumeIndicationInterval(
    VolumeType volumeType,
    SessionChartFilterState filter,
  ) =>
      // get the maximum value from the list and divide it by number of steps
      max(switch (volumeType) {
        VolumeType.count =>
          (maxBy(
                    analysis,
                    (a) => filter.singleBar
                        ? a.count
                        : max(a.countAllowed, a.countBlocked),
                  )?.count ??
                  0) /
              volumeIndicationSteps,
        VolumeType.bytes =>
          (maxBy(
                    analysis,
                    (a) => filter.singleBar
                        ? a.size
                        : max(a.sizeAllowed, a.sizeBlocked),
                  )?.size ??
                  0) /
              volumeIndicationSteps,
      }, 1);
}
