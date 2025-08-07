import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) => oldState.running != state.running,
      builder: (context, state) => state.running
          ? _firewallEnabled(context)
          : _firewallDisabled(context),
    );
  }

  Widget _firewallEnabled(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        CustomIcons.active,
        color: context.colors.positive,
        size: context.textTheme.headlineLarge.size,
      ),
      const Margin.horizontal(ThemeConstants.spacing),
      Text("Firewall is active", style: context.textTheme.headlineLarge),
    ],
  );
  Widget _firewallDisabled(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        CustomIcons.inactive,
        color: context.colors.negative,
        size: context.textTheme.headlineLarge.size,
      ),
      const Margin.horizontal(ThemeConstants.spacing),
      Text("Firewall is disabled", style: context.textTheme.headlineLarge),
    ],
  );
}
