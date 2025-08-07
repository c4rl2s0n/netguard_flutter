import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/session_analysis/sections/session_logs/widgets/log_entry_grouped.dart';
import 'package:netguard/features/session_analysis/sections/session_logs/widgets/log_entry_single.dart';
import 'package:netguard/netguard.dart';

import 'widgets/log_filter_dialog.dart';

class SessionLogs extends StatelessWidget {
  const SessionLogs({super.key});

  static const double _iconSize = ThemeConstants.appIconSize;
  static const double _legendIconSize = 20;

  static Widget filterDialogButton(BuildContext context) {
    return AnalysisFloatingActionButton(
      child: Icon(CustomIcons.filter),
      onPressed: () =>
          LogFilterDialog.show(context, context.read<SessionLogsFilterCubit>()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) =>
          oldState.sessionConfig != state.sessionConfig,
      builder: (context, state) => Column(
        children: [
          Expanded(child: _logs()),
          const Margin.vertical(ThemeConstants.smallSpacing),
          AnalysisColorLegend([
            LegendEntry(
              label: "Allowed",
              color: context.colors.positive,
              icon: CustomIcons.allow,
              indicatorSize: _legendIconSize,
            ),
            if (state.sessionConfig?.observeOnly ?? false) ...[
              LegendEntry(
                label: "Block observed",
                color: context.colors.negative,
                icon: CustomIcons.blockObserve,
                indicatorSize: _legendIconSize,
              ),
            ] else ...[
              LegendEntry(
                label: "Blocked",
                color: context.colors.negative,
                icon: CustomIcons.block,
                indicatorSize: _legendIconSize,
              ),
            ],
          ]),
        ],
      ),
    );
  }

  Widget _logs() {
    return BlocBuilder<SessionLogsFilterCubit, SessionLogsFilterState>(
      builder: (context, filter) => BlocBuilder<SessionCubit, SessionState>(
        buildWhen: (oldState, state) =>
            oldState.sessionAnalysis != state.sessionAnalysis,
        builder: (context, session) =>
            BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
              buildWhen: (oldState, state) =>
                  oldState.logs != state.logs ||
                  oldState.volumeType != state.volumeType,
              builder: (context, analysis) => filter.showGrouped
                  ? _logCompact(session, analysis, filter)
                  : _logSingle(session, analysis, filter),
            ),
      ),
    );
  }

  // COMPACT / GROUPED
  Widget _logCompact(
    SessionState session,
    SessionLogAnalysisState analysisState,
    SessionLogsFilterState filter,
  ) {
    // TODO: do I need to improve this?!
    List<TrafficLogGroup> groups = filter
        .getLog<TrafficLogGroup>(session.sessionAnalysis.state)
        .toList();
    int Function(TrafficLogGroup a, TrafficLogGroup b)? compare =
        ComparisonTools.getSortingFunction(
          filter.sorting,
          getApplication: (x) => session.applicationsMap[x.packageName],
          getName: (x) => x.destination,
          getVolume: switch (analysisState.volumeType) {
            VolumeType.count => (x) => x.count.toDouble(),
            VolumeType.bytes => (x) => x.size.toDouble(),
          },
        );
    if (compare != null) groups.sort(compare);
    return ListView.separated(
      itemCount: groups.length,
      itemBuilder: (context, index) => LogEntryGrouped(groups[index]),
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: ThemeConstants.spacing),
    );
  }

  // NORMAL

  Widget _logSingle(
    SessionState session,
    SessionLogAnalysisState analysisState,
    SessionLogsFilterState filter,
  ) {
    List<TrafficLog> logs = filter
        .getLog<TrafficLog>(session.sessionAnalysis.state)
        .toList();

    int Function(TrafficLog a, TrafficLog b)? compare =
        ComparisonTools.getSortingFunction(
          filter.sorting,
          getTime: (x) => x.time,
          getApplication: (x) => session.applicationsMap[x.packageName],
          getName: (x) => x.destination,
        );
    if (compare != null) logs.sort(compare);
    return ListView.separated(
      itemCount: logs.length,
      itemBuilder: (context, index) =>
          LogEntrySingle(logs[logs.length - 1 - index]),
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: ThemeConstants.spacing),
    );
  }
}
