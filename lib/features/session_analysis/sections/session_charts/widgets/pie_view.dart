import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

import 'pie_chart.dart';

class PieView extends StatelessWidget {
  const PieView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
      buildWhen: (oldState, state) => oldState.groupType != state.groupType,
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

              return SingleChildScrollView(
                child: GridView.count(
                  crossAxisCount: _gridCrossAxisCount(analysis),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: ThemeConstants.spacing,
                  crossAxisSpacing: ThemeConstants.spacing,
                  children: analysis.map((a) => PieChart(a)).toList(),
                ),
              );
            },
          ),
    );
  }

  Widget _pieChart<T extends TrafficLogAggregation>(T analysis) {
    if (analysis is TrafficLogByApplication) {
      // Update Single Chart only when its values change (by Application)
      TrafficLogByApplication byApp = analysis as TrafficLogByApplication;
      return BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
        buildWhen: (oldState, state) =>
            oldState.analysisByApplication[byApp.application?.packageName] !=
            state.analysisByApplication[byApp.application?.packageName],
        builder: (context, state) =>
            state.analysisByApplication.containsKey(
              byApp.application?.packageName,
            )
            ? PieChart(
                state.analysisByApplication[byApp.application?.packageName]!,
              )
            : Center(child: Text(byApp.application?.packageName ?? "Unknown")),
      );
    } else if (analysis is TrafficLogByDestination) {
      // Update Single Chart only when its values change (by Destination)
      TrafficLogByDestination byDest = analysis as TrafficLogByDestination;
      return BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
        buildWhen: (oldState, state) =>
            oldState.analysisByDestination[byDest.destination] !=
            state.analysisByDestination[byDest.destination],
        builder: (context, state) =>
            state.analysisByDestination.containsKey(byDest.destination)
            ? PieChart(state.analysisByDestination[byDest.destination]!)
            : Center(child: Text(byDest.destination)),
      );
    }
    return PieChart(analysis);
  }

  int _gridCrossAxisCount<T extends TrafficLogAggregation>(List<T> analysis) {
    bool isApp = T == TrafficLogByApplication;
    int entryCount = analysis.length;
    if (entryCount == 1) return 1;
    if (entryCount <= 4) return 2;
    //if(!isApp) return 2;
    return 3;
  }
}
