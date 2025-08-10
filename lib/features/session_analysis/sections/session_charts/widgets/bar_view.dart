import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

import 'bars_chart.dart';

class BarView extends StatelessWidget {
  const BarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
      buildWhen: (oldState, state) =>
          oldState.groupType != state.groupType ||
          oldState.sorting != state.sorting ||
          oldState.filterApplications != state.filterApplications,
      builder: (context, filter) =>
          BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
            buildWhen: (oldState, state) =>
                oldState.logs != state.logs ||
                filter.groupType == GroupType.application &&
                    oldState.applicationsSortedFiltered !=
                        state.applicationsSortedFiltered ||
                filter.groupType == GroupType.destination &&
                    oldState.destinationsSortedFiltered !=
                        state.destinationsSortedFiltered,
            builder: (context, state) {
              List<TrafficLogAggregation> analysis = state
                  .forType(filter.groupType)
                  .toList();

              return SingleChildScrollView(
                child: switch (filter.groupType) {
                  GroupType.application => BarsChart<TrafficLogByApplication>(
                    analysis as List<TrafficLogByApplication>,
                  ),
                  GroupType.destination => BarsChart<TrafficLogByDestination>(
                    analysis as List<TrafficLogByDestination>,
                  ),
                },
              );
            },
          ),
    );
  }
}
