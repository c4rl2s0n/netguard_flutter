import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/session_logs/session_logs.dart';
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

  static const double _buttonSize = 200;
  Widget _content() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) => oldState.running != state.running,
      builder: (context, session) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (session.running) _stop(context) else _start(context),
            const Margin.vertical(ThemeConstants.spacing),
            _showLogsBtn(context),
          ],
        ),
      ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text("Firewall disabled", style: context.textTheme.displaySmall),
            Transform.flip(flipX: true, child: icon),
          ],
        ),
        const Margin.vertical(ThemeConstants.spacing),
        IconButton(
          onPressed: () async {
            await sessionCubit.startVpn();
            if (settingsCubit.state.logTraffic && context.mounted)
              _showLogs(context);
          },
          style: IconButton.styleFrom(
            backgroundColor: context.colors.onBackground,
            foregroundColor: context.colors.positive,
          ),
          icon: Icon(CustomIcons.start, size: _buttonSize),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.flip(flipX: true, child: icon),
            Text("Firewall is active", style: context.textTheme.displaySmall),
            icon,
          ],
        ),
        const Margin.vertical(ThemeConstants.spacing),
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
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) =>
          oldState.sessionLogState != state.sessionLogState,
      builder: (context, state) => state.sessionLogState.hasLogs
          ? IconTextButton(
              icon: Icon(CustomIcons.logs),
              text: "Session Logs",
              onTap: () => _showLogs(context),
            )
          : SizedBox.shrink(),
    );
  }

  void _showLogs(BuildContext context) =>
      context.navigator.navigateTo(const SessionLogs());
}
