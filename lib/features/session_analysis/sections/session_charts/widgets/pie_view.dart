import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

import 'pie_chart.dart';

class PieView extends StatelessWidget {
  const PieView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
      buildWhen: (oldState, state) =>
          oldState.groupType != state.groupType ||
          oldState.sorting != state.sorting ||
          oldState.filterApplications != state.filterApplications,
      builder: (context, filter) =>
          BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
            buildWhen: (oldState, state) => oldState.logs != state.logs,
            // filter.groupType == GroupType.application &&
            //     oldState.applicationsSortedFiltered !=
            //         state.applicationsSortedFiltered ||
            // filter.groupType == GroupType.destination &&
            //     oldState.destinationsSortedFiltered !=
            //         state.destinationsSortedFiltered,
            builder: (context, state) {
              List<TrafficLogAggregation> analysis = state
                  .forType(filter.groupType)
                  .toList();

              return LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = _gridCrossAxisCount(analysis);
                  double chartWidth =
                      (constraints.maxWidth / crossAxisCount) -
                      (crossAxisCount - 1) * ThemeConstants.spacing;
                  double chartHeight = chartWidth + 55;
                  return SingleChildScrollView(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: ThemeConstants.spacing,
                        crossAxisSpacing: ThemeConstants.spacing,
                        mainAxisExtent: chartHeight + ThemeConstants.spacing,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: analysis.length,
                      itemBuilder: (context, index) => PieChart(
                        analysis[index],
                        size: Size(chartWidth, chartHeight),
                      ),
                    ),
                  );
                },
              );
            },
          ),
    );
  }

  int _gridCrossAxisCount<T extends TrafficLogAggregation>(List<T> analysis) {
    int entryCount = analysis.length;
    if (entryCount == 1) return 1;
    if (entryCount <= 4) return 2;
    return 3;
  }
}
