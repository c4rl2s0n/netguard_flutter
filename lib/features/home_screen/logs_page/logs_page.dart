import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(
        context,
        title: "Session Logs",
        actions: [PageComponentFactory.settingsNavigationButton(context)],
      ),
      body: Column(
        children: [
          Todo("Compact view (group by Application, Protocol, IP/Host, Allowed"),
          Expanded(child: _log()),
        ],
      ),
    );
  }

  Widget _log() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) =>
          oldState.sessionTrafficLog != state.sessionTrafficLog,
      builder: (context, state) => ListView.separated(
        itemCount: state.sessionTrafficLog.length,
        itemBuilder: (context, index) =>
            _logEntry(context, state.sessionTrafficLog[index], state),
        separatorBuilder: (BuildContext context, int index) =>
            const Margin.vertical(ThemeConstants.spacing),
      ),
    );
  }

  Widget _logEntry(BuildContext context, TrafficLog log, SessionState session) {
    Application? application = session.applicationsMap[log.packageName];
    DateTime time = DateTime.fromMillisecondsSinceEpoch(log.time);
    String timeStr = time.isToday ? time.hms : time.noMs;
    double iconSize = 26;
    return Row(
      children: [
        SizedBox.square(
          dimension: iconSize,
          child: application?.image ?? Icon(CustomIcons.question),
        ),
        Expanded(
          child: Text(
            "$timeStr: ${NetworkingTools.toProtocol(log.protocol)} ${log.host ?? log.ip}",
          ),
        ),
        log.allowed
            ? Icon(
                CustomIcons.allow,
                color: context.colors.positive,
                size: iconSize,
              )
            : Icon(
                CustomIcons.block,
                color: context.colors.negative,
                size: iconSize,
              ),
      ].insertBetweenItems(() => const Margin.horizontal(ThemeConstants.spacing)),
    );
  }
}
