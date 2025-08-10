import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

class StatisticsOverview extends StatelessWidget {
  const StatisticsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
      buildWhen: (oldState, state) =>
          oldState.volumeType != state.volumeType ||
          oldState.logs != state.logs,
      builder: (context, analysis) => BlocBuilder<SessionCubit, SessionState>(
        buildWhen: (oldState, state) =>
            oldState.sessionStatistics != state.sessionStatistics ||
            oldState.running != state.running,
        builder: (context, session) => _layout(
          topLeft: _totalVolume(
            context,
            session.sessionStatistics,
            analysis.volumeType,
          ),
          topRight: _blockedVolume(
            context,
            session.sessionStatistics,
            analysis.volumeType,
          ),
          bottomLeft: _statApplication(
            context,
            session,
            "Most Traffic",
            session.sessionStatistics.mostTrafficPackage,
          ),
          bottomRight: _statApplication(
            context,
            session,
            "Most Blocked",
            session.sessionStatistics.mostBlockedPackage,
          ),
        ),
      ),
    );
  }

  Widget _totalVolume(
    BuildContext context,
    SessionStatistics sessionStatistics,
    VolumeType volumeType,
  ) => switch (volumeType) {
    VolumeType.count => _statNumber(
      context,
      "Packets (Total)",
      sessionStatistics.packetCount.toString(),
    ),
    VolumeType.bytes => _statNumber(
      context,
      "Bytes (Total)",
      sessionStatistics.packetSize.readableFileSize(),
    ),
  };
  Widget _blockedVolume(
    BuildContext context,
    SessionStatistics sessionStatistics,
    VolumeType volumeType,
  ) => switch (volumeType) {
    VolumeType.count => _statNumber(
      context,
      "Packets (Blocked)",
      sessionStatistics.packetCountBlocked.toString(),
    ),
    VolumeType.bytes => _statNumber(
      context,
      "Bytes (Blocked)",
      sessionStatistics.packetSizeBlocked.readableFileSize(),
    ),
  };

  Widget _layout({
    required Widget topLeft,
    required Widget topRight,
    required Widget bottomLeft,
    required Widget bottomRight,
  }) => GridView.count(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    mainAxisSpacing: 0,
    crossAxisSpacing: 0,
    children: [
      _topLeft(topLeft),
      _topRight(topRight),
      _bottomLeft(bottomLeft),
      _bottomRight(bottomRight),
    ],
  );
  BorderSide _borderSide(BuildContext context) =>
      BorderSide(color: context.colors.divider, width: 2);
  Widget _container(
    Widget child, {
    bool bLeft = false,
    bool bRight = false,
    bool bTop = false,
    bool bBottom = false,
  }) => Builder(
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            left: bLeft ? _borderSide(context) : BorderSide.none,
            right: bRight ? _borderSide(context) : BorderSide.none,
            top: bTop ? _borderSide(context) : BorderSide.none,
            bottom: bBottom ? _borderSide(context) : BorderSide.none,
          ),
        ),
        child: child,
      );
    },
  );
  Widget _topLeft(Widget child) => _container(child, bRight: true);
  Widget _topRight(Widget child) => _container(child, bBottom: true);
  Widget _bottomLeft(Widget child) => _container(child, bTop: true);
  Widget _bottomRight(Widget child) => _container(child, bLeft: true);

  Widget _statNumber(BuildContext context, String title, String value) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const Margin.vertical(ThemeConstants.spacing),

          Text(
            value,
            style: context.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _statApplication(
    BuildContext context,
    SessionState session,
    String title,
    String? packageName,
  ) {
    Application? application = session.applicationsMap[packageName ?? ""];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox.square(dimension: 80, child: application?.wIcon),
        ),

        Text(
          application.label,
          style: context.textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        const Margin.vertical(ThemeConstants.spacing),
        Text(
          title,
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
