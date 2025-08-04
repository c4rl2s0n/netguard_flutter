import 'package:flutter/material.dart';
import 'package:netguard/netguard.dart';

class VpnLauncher extends StatelessWidget {
  const VpnLauncher(this.buildChild, {super.key});

  final Widget Function(Future Function(BuildContext context) launchVpn)
  buildChild;

  @override
  Widget build(BuildContext context) {
    return buildChild(_launchVpn);
  }

  Future _launchVpn(BuildContext context) async {
    if (settingsCubit.state.observeOnly) {
      bool? shouldContinue = await ConfirmationDialog.askOptional(
        context,
        title: "Observation-Mode enabled",
        content:
            "In observation mode, the traffic will NOT be filtered! Do you want to start the firewall in observation mode?",
        declineText: "Turn OFF",
        confirmText: "Continue",
      );
      if (shouldContinue == null) {
        return;
      } else if (!shouldContinue) {
        settingsCubit.setObserveOnly(false);
      }
    }
    await sessionCubit.startVpn();
    if (settingsCubit.state.logTraffic && context.mounted) {
      context.navigator.navigateAndClearRoute(const SessionAnalysisView());
    }
  }
}
