import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/session_logs/logic/session_logs_filter_cubit.dart';
import 'package:netguard/features/session_logs/widgets/log_filter_dialog.dart';
import 'package:netguard/netguard.dart';

class SessionLogs extends StatelessWidget {
  const SessionLogs({super.key});

  static const double _iconSize = ThemeConstants.appIconSize;

  // TODO: show packet size in logs

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionLogsFilterCubit(settingsCubit),
      child: Builder(
        builder: (context) {
          SessionLogsFilterCubit filterCubit = context
              .read<SessionLogsFilterCubit>();
          return PageComponentFactory.scaffold(
            context,
            appBar: PageComponentFactory.appBar(
              context,
              title: "Session Logs",
              actions: [
                PageComponentFactory.appBarIconButton(
                  (context) => LogFilterDialog.show(context, filterCubit),
                  CustomIcons.filter,
                ),
                PageComponentFactory.settingsNavigationButton(),
              ],
            ),
            body: _log(),
          );
        },
      ),
    );
  }

  Widget _log() {
    return BlocBuilder<SessionLogsFilterCubit, SessionLogsFilterState>(
      builder: (context, filter) => BlocBuilder<SessionCubit, SessionState>(
        buildWhen: (oldState, state) =>
            oldState.sessionLogState != state.sessionLogState,
        builder: (context, session) => filter.showGrouped
            ? _logCompact(session, filter)
            : _logSingle(session, filter),
      ),
    );
  }

  // COMPACT / GROUPED

  Widget _logCompact(SessionState session, SessionLogsFilterState filter) {
    List<TrafficLogGroup> groups = filter
        .getLog<TrafficLogGroup>(session.sessionLogState)
        .toList();
    return ListView.separated(
      itemCount: groups.length,
      itemBuilder: (context, index) =>
          _logEntryGroup(context, groups[index], session),
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: ThemeConstants.spacing),
    );
  }

  Widget _logEntryGroup(
    BuildContext context,
    TrafficLogGroup log,
    SessionState session,
  ) {
    String text =
        "${NetworkingTools.toPortAwareProtocol(log.protocol, log.dport)} ${log.destination}";
    Widget content = Row(
      children: [
        Expanded(child: Text(text)),
        Text(log.count.toString()),
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

  Widget _logSingle(SessionState session, SessionLogsFilterState filter) {
    List<TrafficLog> logs = filter
        .getLog<TrafficLog>(session.sessionLogState)
        .toList();
    return ListView.separated(
      itemCount: logs.length,
      itemBuilder: (context, index) =>
          _logEntrySingle(context, logs[logs.length - 1 - index], session),
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: ThemeConstants.spacing),
    );
  }

  Widget _logEntrySingle(
    BuildContext context,
    TrafficLog log,
    SessionState session,
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
      child: text,
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
