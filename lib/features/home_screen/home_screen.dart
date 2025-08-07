import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/home_screen/widgets/firewall_control_button.dart';
import 'package:netguard/features/home_screen/widgets/home_title.dart';
import 'package:netguard/features/home_screen/widgets/statistics_overview.dart';
import 'package:netguard/netguard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(
        context,
        title: "NetGuard",
        actions: [PageComponentFactory.settingsNavigationButton()],
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Margin.vertical(ThemeConstants.largeSpacing),
          const HomeTitle(),
          Expanded(child: _statistics()),
          _extraButton(),
        ],
      ),
    );
  }

  Widget _statistics() {
    return Stack(
      alignment: Alignment.center,
      children: [
        const StatisticsOverview(),
        Positioned.fill(child: Center(child: const FirewallControlButton())),
      ],
    );
  }

  Widget _extraButton() {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) => Column(
        children: [
          const Margin.vertical(ThemeConstants.spacing),
          state.running ? _showLogsBtn() : _runObservationBtn(),
        ],
      ),
    );
  }

  Widget _runObservationBtn() {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) => IconTextButton(
        icon: Icon(CustomIcons.observationMode),
        text: "Run Observation Mode",
        onTap: () async {
          if (await ConfirmationDialog.ask(
                context,
                title: "Start Observation-Mode",
                content:
                    "In observation-mode, the firewall does not block any traffic. It just observes the traffic and logs, which traffic would usually be blocked. This can be useful to get a better impression of the actual impact of the firewall rules.\n\nDo you want to start the firewall in observation mode?",
                declineText: "No",
                confirmText: "Yes",
              ) &&
              context.mounted) {
            await sessionCubit.startVpn(observeOnly: true);
            if (context.mounted) {
              context.navigator.navigateAndClearRoute(
                const SessionAnalysisView(),
              );
            }
          }
        },
      ),
    );
  }

  Widget _showLogsBtn() {
    return BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
      buildWhen: (oldState, state) => oldState.hasLogs != state.hasLogs,
      builder: (context, state) => state.hasLogs
          ? IconTextButton(
              icon: Icon(CustomIcons.logs),
              text: "Session Logs",
              onTap: () => _showLogs(context),
            )
          : SizedBox.shrink(),
    );
  }

  void _showLogs(BuildContext context) =>
      context.navigator.navigateTo(const SessionAnalysisView());
}
