import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

import 'widgets/log_filter_dialog.dart';

class SessionLogs extends StatelessWidget {
  const SessionLogs({super.key});

  static const double _iconSize = ThemeConstants.appIconSize;
  static const double _legendIconSize = 20;

  // TODO: show packet size in logs
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
      buildWhen: (oldState, state) => oldState.sessionConfig != state.sessionConfig,
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
            if(state.sessionConfig?.observeOnly ?? false)...[
              LegendEntry(
                label: "Block observed",
                color: context.colors.negative,
                icon: CustomIcons.blockObserve,
                indicatorSize: _legendIconSize,
              ),
            ]else...[
              LegendEntry(
                label: "Blocked",
                color: context.colors.negative,
                icon: CustomIcons.block,
                indicatorSize: _legendIconSize,
              ),
            ]

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
      itemBuilder: (context, index) => _logEntryGroup(
        context,
        groups[index],
        session,
        analysisState,
      ),
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: ThemeConstants.spacing),
    );
  }

  Widget _logEntryGroup(
    BuildContext context,
    TrafficLogGroup log,
    SessionState session,
    SessionLogAnalysisState analysisState,
  ) {
    String text =
        "${NetworkingTools.toPortAwareProtocol(log.protocol, log.dport)} ${log.destination}";
    Widget content = Row(
      children: [
        Expanded(child: Text(text)),
        Text(switch (analysisState.volumeType) {
          VolumeType.count => log.count.toString(),
          VolumeType.bytes => log.size.readableFileSize(),
        }),
      ],
    );

    content = GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: log.destination));
        SnackBarFactory.showPositiveSnackBar(
          "Copied destination (${log.destination}) to clipboard",
        );
      },
      child: content,
    );
    return _logEntry(context, log.packageName, content, log.allowed, session);
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
          getApplication: (x) => session.applicationsMap[x.packageName],
          getName: (x) => x.destination,
        );
    if (compare != null) logs.sort(compare);
    return ListView.separated(
      itemCount: logs.length,
      itemBuilder: (context, index) => _logEntrySingle(
        context,
        logs[logs.length - 1 - index],
        session,
        analysisState,
      ),
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: ThemeConstants.spacing),
    );
  }

  Widget _logEntrySingle(
    BuildContext context,
    TrafficLog log,
    SessionState session,
    SessionLogAnalysisState analysisState,
  ) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(log.time);
    String timeStr = time.isToday ? time.hms : time.noMs;
    Widget text = Text(
      "$timeStr: ${NetworkingTools.toPortAwareProtocol(log.protocol, log.dport)} ${log.destination}:${log.dport}",
    );
    Widget content = GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: log.destination));
        SnackBarFactory.showPositiveSnackBar(
          "Copied destination (${log.destination}) to clipboard",
        );
      },
      child: Row(
        children: [
          Expanded(child: text),
          if (analysisState.volumeType == VolumeType.bytes)
            Text(log.size.readableFileSize()),
        ],
      ),
    );
    return _logEntry(context, log.packageName, content, log.allowed, session);
  }

  Widget _logEntry(
    BuildContext context,
    String? packageName,
    Widget content,
    bool allowed,
    SessionState session,
  ) {
    Application? application = session.applicationsMap[packageName];
    return Row(
      children:
          [
            SizedBox.square(
              dimension: _iconSize,
              child: application?.image ?? Icon(CustomIcons.question),
            ),
            Expanded(child: content),
            allowed
                ? Icon(
                    CustomIcons.allow,
                    color: context.colors.positive,
                    size: _iconSize,
                  )
                : Icon(
                    CustomIcons.block,
                    color: context.colors.negative,
                    size: _iconSize,
                  ),
          ].insertBetweenItems(
            () => const Margin.horizontal(ThemeConstants.spacing),
          ),
    );
  }
}
