import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/settings/global_rules_settings/global_rules_settings.dart';
import 'package:netguard/features/settings/global_rules_settings/logic/rule_import_task.dart';
import 'package:netguard/netguard.dart';

class VpnSettings extends StatelessWidget {
  const VpnSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) => oldState.running != state.running,
      builder: (context, session) => SettingsGroup(
        title: "VPN Settings",
        settings: [_systemApps(), _globalRules(), _ruleImport()],
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

  Widget _ruleImport() {
    return ActionSetting(
      name: "Import Rules",
      description: "Import firewall rules from a JSON file",
      trailing: Icon(CustomIcons.import),
      action: (context) async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          dialogTitle: "Select file to scan for rules",
          allowMultiple: false,
        );

        List<String> files = [];
        if (result != null) {
          files = result.paths.nonNulls.toList();
        }
        if (files.isEmpty) {
          SnackBarFactory.showNegativeSnackBar("No files selected...");
          return;
        }
        if (context.mounted) {
          LoadingDialog.show(context, (context, lc) async {
            await RuleImportTask().execute(
              lc,
              RuleImportTaskArgument(await databaseConnection, files.first),
            );
            await sessionCubit.loadApplications();
          });
        }
      },
    );
  }
}
