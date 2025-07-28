import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/features/applications_view/applications_view.dart';
import 'package:netguard/features/features.dart';
import 'package:netguard/features/session_logs/session_logs.dart';

import 'nav_drawer_entry.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<SessionCubit, SessionState>(
        buildWhen: (oldState, state) => oldState.hasLogs != state.hasLogs,
        builder: (context, state) => ListView(
          padding: EdgeInsets.zero,
          children: [_header(context), ..._getEntries(state)],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    TextStyle? style = context.textTheme.displaySmall;
    Widget icon = Icon(CustomIcons.appIcon, size: style.size);
    return DrawerHeader(
      child: Center(
        child: Row(
          children: [
            icon,
            const Margin.horizontal(ThemeConstants.spacing),
            Text("NetGuard", style: style),
            //Transform.flip(flipX: true, child: icon),
          ],
        ),
      ),
    );
  }

  List<Widget> _getEntries(SessionState session) {
    return [
      NavDrawerEntry(
        title: "Home",
        icon: CustomIcons.home,
        buildDestination: (_) => const HomeScreen(),
      ),
      NavDrawerEntry(
        title: "Applications",
        icon: CustomIcons.applications,
        buildDestination: (_) => const ApplicationsView(),
      ),
      if (session.hasLogs) ...[
        NavDrawerEntry(
          title: "Session Logs",
          icon: CustomIcons.logs,
          buildDestination: (_) => const SessionLogs(),
        ),
      ],
      NavDrawerEntry(
        title: "Settings",
        icon: CustomIcons.settings,
        buildDestination: (_) => const SettingsView(),
      ),
    ];
  }
}
