import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/features/applications_view/applications_view.dart';
import 'package:netguard/features/features.dart';

import 'nav_drawer_entry.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _header(context),
          ..._getEntries(),
        ],
      ),
    );
  }

  Widget _header(BuildContext context){
    TextStyle? style = context.textTheme.displaySmall;
    Widget icon = Icon(CustomIcons.appIcon, size: style.size,);
    return DrawerHeader(child: Center(child: Row(
      children: [
        icon,
        Text("NetGuard", style: style,),
        Transform.flip(flipX: true, child: icon,)
      ],
    )));
  }

  List<Widget> _getEntries() {
    return [
      NavDrawerEntry(
        title: "Home",
        icon: CustomIcons.home,
        buildDestination: (_) => HomeScreen(),
      ),
      NavDrawerEntry(
        title: "Applications",
        icon: CustomIcons.applications,
        buildDestination: (_) => ApplicationsView(),
      ),
    ];
  }
}
