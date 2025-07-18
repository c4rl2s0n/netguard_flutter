import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/settings/global_rules_settings/global_rules_settings.dart';
import 'package:netguard/netguard.dart';

class VpnSettings extends StatelessWidget {
  const VpnSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) => oldState.running != state.running,
      builder: (context, session) => SettingsGroup(
        title: "VPN Settings",
        settings: [_systemApps(), _globalRules()],
        info: session.running
            ? Text(
                "These settings will only be affective after restarting the VPN.",
                style: context.textTheme.labelMedium!.copyWith(
                  color: context.colors.warning,
                ),
              )
            : null,
      ),
    );
  }

  Widget _systemApps() {
    return SimpleSetting(
      name: "Include System Applications",
      description: "If system applications should be filtered by the firewall",
      action: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (oldState, state) =>
            oldState.includeSystemApps != state.includeSystemApps,
        builder: (context, state) {
          return Switch(
            value: state.includeSystemApps,
            onChanged: (_) => settingsCubit.toggleIncludeSystemApps(),
          );
        },
      ),
    );
  }
  Widget _globalRules() {
    return NavigationSetting(
      name: "Configure global rules",
      description: "Define rules that are applied for all applications",
      getDestination: (context) => GlobalRulesSettings(),
    );
  }
}
