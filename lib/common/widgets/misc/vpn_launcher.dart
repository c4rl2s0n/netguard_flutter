import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/features/session_logs/session_logs.dart';

class VpnLauncher extends StatelessWidget {
  const VpnLauncher(this.buildChild, {super.key});

  final Widget Function(Future Function(BuildContext context) launchVpn)
  buildChild;

  @override
  Widget build(BuildContext context) {
    return buildChild(_launchVpn);
  }

  Future _launchVpn(BuildContext context) async {
    if (settingsCubit.state.observeOnly &&
        !await ConfirmationDialog.ask(
          context,
          title: "Observation-Mode enabled",
          content:
              "In observation mode, the traffic will NOT be filtered! Do you want to start the firewall in observation mode?",
          declineText: "Turn OFF",
          confirmText: "Continue",
        )) {
      settingsCubit.setObserveOnly(false);
    }
    await sessionCubit.startVpn();
    if (settingsCubit.state.logTraffic && context.mounted) {
      context.navigator.navigateAndClearRoute(const SessionLogs());
    }
  }
}
