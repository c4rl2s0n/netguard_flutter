import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(
        context,
        title: "Home",
        actions: [PageComponentFactory.settingsNavigationButton()],
      ),
      body: _content(),
    );
  }

  static const double _buttonSize = 100;
  Widget _content() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) => oldState.running != state.running,
      builder: (context, session) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: _statistics()),
            //if (session.running) _stop(context) else _start(context),
            _showLogsBtn(context),
          ],
        ),
      ),
    );
  }

  // TODO: Cleanup!
  Widget _statistics() {
    return BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
      buildWhen: (oldState, state) =>
          oldState.volumeType != state.volumeType ||
          oldState.logs != state.logs,
      builder: (context, state) => BlocBuilder<SessionCubit, SessionState>(
        buildWhen: (oldState, state) =>
            oldState.sessionStatistics != state.sessionStatistics || oldState.running != state.running,
        builder: (context, session) => Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(color: context.colors.divider),
                            ),
                          ),
                          child: Center(
                            child: _statNumber(
                              context,
                              "Packets (Total)",
                              session.sessionStatistics.packetCount.toString(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: context.colors.divider),
                            ),
                          ),
                          child: Center(
                            child: _statNumber(
                              context,
                              "Packets (Blocked)",
                              session.sessionStatistics.packetCountBlocked
                                  .toString(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: context.colors.divider),
                            ),
                          ),
                          child: Center(
                            child: _statApplication(
                              context,
                              session,
                              "Most Blocked Application",
                              session.sessionStatistics.mostBlockedPackage,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: context.colors.divider),
                            ),
                          ),
                          child: Center(
                            child: _statApplication(
                              context,
                              session,
                              "Most Traffic Application",
                              session.sessionStatistics.mostTrafficPackage,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Center(
                child: session.running ? _stop(context) : _start(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: SizedBox.square(
            dimension: 80,
            child: session.applicationsMap[packageName ?? ""]?.wIcon,
          ),
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

  Widget _start(BuildContext context) {
    Widget icon = Icon(
      CustomIcons.inactive,
      size: context.textTheme.displaySmall?.fontSize,
      color: context.colors.warning,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     icon,
        //     Text("Firewall disabled", style: context.textTheme.displaySmall),
        //     Transform.flip(flipX: true, child: icon),
        //   ],
        // ),
        // const Margin.vertical(ThemeConstants.spacing),
        VpnLauncher(
          (launchVpn) => IconButton(
            onPressed: () => launchVpn(context),
            style: IconButton.styleFrom(
              backgroundColor: context.colors.onBackground,
              foregroundColor: context.colors.positive,
            ),
            icon: Icon(CustomIcons.start, size: _buttonSize),
          ),
        ),
      ],
    );
  }

  Widget _stop(BuildContext context) {
    Widget icon = Icon(
      CustomIcons.active,
      size: context.textTheme.displaySmall?.fontSize,
      color: context.colors.positive,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Transform.flip(flipX: true, child: icon),
        //     Text("Firewall is active", style: context.textTheme.displaySmall),
        //     icon,
        //   ],
        // ),
        // const Margin.vertical(ThemeConstants.spacing),
        IconButton(
          onPressed: sessionCubit.stopVpn,
          style: IconButton.styleFrom(
            backgroundColor: context.colors.onBackground,
            foregroundColor: context.colors.negative,
          ),
          icon: Icon(CustomIcons.stop, size: _buttonSize),
        ),
      ],
    );
  }

  Widget _showLogsBtn(BuildContext context) {
    return BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
      buildWhen: (oldState, state) => oldState.hasLogs != state.hasLogs,
      builder: (context, state) => state.hasLogs
          ? Column(
              children: [
                const Margin.vertical(ThemeConstants.spacing),
                IconTextButton(
                  icon: Icon(CustomIcons.logs),
                  text: "Session Logs",
                  onTap: () => _showLogs(context),
                ),
              ],
            )
          : SizedBox.shrink(),
    );
  }

  void _showLogs(BuildContext context) =>
      context.navigator.navigateTo(const SessionLogs());
}
