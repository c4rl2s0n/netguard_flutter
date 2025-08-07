import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

class FirewallControlButton extends StatelessWidget {
  const FirewallControlButton({super.key});

  static const double _buttonSize = 80;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) => oldState.running != state.running,
      builder: (context, state) =>
      state.running ? _stop(context) : _start(context),
    );
  }

  Widget _start(BuildContext context) => VpnLauncher(
        (launchVpn) => IconButton(
      onPressed: () => launchVpn(context),
      style: IconButton.styleFrom(
        backgroundColor: context.colors.onBackground,
        foregroundColor: context.colors.positive,
      ),
      icon: Icon(CustomIcons.start, size: _buttonSize),
    ),
  );

  Widget _stop(BuildContext context) => IconButton(
    onPressed: sessionCubit.stopVpn,
    style: IconButton.styleFrom(
      backgroundColor: context.colors.onBackground,
      foregroundColor: context.colors.negative,
    ),
    icon: Icon(CustomIcons.stop, size: _buttonSize),
  );
}
