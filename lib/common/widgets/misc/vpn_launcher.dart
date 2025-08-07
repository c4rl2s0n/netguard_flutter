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
    await sessionCubit.startVpn();
    if (settingsCubit.state.logTraffic && context.mounted) {
      context.navigator.navigateAndClearRoute(const SessionAnalysisView());
    }
  }
}
