import 'package:flutter/material.dart';
import 'package:netguard/netguard.dart';

import 'widgets/widgets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(context, title: "Settings"),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Todo("TrafficLog cache duration (TTL)"),
        const ThemeSettings(),
        const VpnSettings(),
      ],
    );
  }
}
