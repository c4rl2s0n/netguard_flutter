import 'package:flutter/material.dart';
import 'package:netguard/netguard.dart';

class VpnLauncher extends StatelessWidget {
  const VpnLauncher(this.buildChild, {this.navigateOnStart = true, super.key});

  final Widget Function(Future Function(BuildContext context) launchVpn)
  buildChild;
  final bool navigateOnStart;

  @override
  Widget build(BuildContext context) {
    return buildChild(_launchVpn);
  }

  Future _launchVpn(BuildContext context) async {
    await sessionCubit.startVpn();
    if(!navigateOnStart || !context.mounted) return;
    if (settingsCubit.state.logTraffic) {
      context.navigator.navigateAndClearRoute(const SessionAnalysisView());
    }else{
      context.navigator.navigateAndClearRoute(const HomeScreen());
    }
  }
}
