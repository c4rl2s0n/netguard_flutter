import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/settings/global_rules_settings/logic/global_rules_cubit.dart';
import 'package:netguard/features/settings/global_rules_settings/widgets/rule_source_entry.dart';
import 'package:netguard/netguard.dart';

class GlobalRulesSettings extends StatelessWidget {
  const GlobalRulesSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GlobalRulesCubit(),
      child: PageComponentFactory.scaffold(
        context,
        appBar: PageComponentFactory.appBar(
          context,
          title: "Global Rules",
          actions: [_scanSourcesButton()],
        ),
        body: _buildContent(context),
      ),
    );
  }

  Widget _scanSourcesButton() {
    return Builder(
      builder: (context) {
        return IconButton(
          onPressed: () => LoadingDialog.show(
            context,
            (context, loadingCubit) =>
                context.read<GlobalRulesCubit>().scanSources(loadingCubit),
          ),
          icon: Icon(CustomIcons.scan),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<GlobalRulesCubit, GlobalRulesState>(
      buildWhen: (oldState, state) => oldState.loading != state.loading,
      builder: (context, state) => state.loading
          ? Center(child: CircularProgressIndicator())
          : OnLeaveUpdater(
              update: (context) => context.read<GlobalRulesCubit>().store(),
              child: BlocBuilder<SessionCubit, SessionState>(
                buildWhen: (oldState, state) =>
                    oldState.running != state.running,
                builder: (context, session) => SingleChildScrollView(
                  child: Column(
                    children: [
                      _lastScanIndication(),
                      if (session.running) ...[
                        Text(
                          "These settings will only be effective after restarting the VPN.",
                          style: context.textTheme.labelMedium!.copyWith(
                            color: context.colors.warning,
                          ),
                        ),
                      ],
                      _online(context),
                      _offline(context),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _lastScanIndication() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) =>
          oldState.lastBlacklistUpdate != state.lastBlacklistUpdate,
      builder: (context, state) {
        TextStyle? style = context.textTheme.bodyLarge;
        return state.lastBlacklistUpdate == null
            ? Text(
                "No rules have been scanned!",
                style: style?.copyWith(color: context.colors.warning),
              )
            : Text(state.lastBlacklistUpdate.toString(), style: style);
      },
    );
  }

  Widget _addSourceButton(BuildContext context, SourceType type) {
    return IconButton(
      onPressed: () => context.read<GlobalRulesCubit>().createSource(type),
      icon: Icon(CustomIcons.add, color: context.colors.positive),
    );
  }

  Widget _online(BuildContext context) {
    return BlocBuilder<GlobalRulesCubit, GlobalRulesState>(
      buildWhen: (oldState, state) =>
          oldState.onlineSources != state.onlineSources,
      builder: (context, state) => SettingsGroup(
        title: "Online Sources",
        action: _addSourceButton(context, SourceType.online),
        info: Text(
          "Specify a list of URLs to websites that contain hosts or ips to be blocked",
        ),
        settings: state.onlineSources.map((s) => RuleSourceEntry(s)).toList(),
      ),
    );
  }

  Widget _offline(BuildContext context) {
    return BlocBuilder<GlobalRulesCubit, GlobalRulesState>(
      buildWhen: (oldState, state) =>
          oldState.localSources != state.localSources,
      builder: (context, state) => SettingsGroup(
        title: "Local Sources",
        info: Text(
          "Specify a list of files that contain hosts or ips to be blocked",
        ),
        settings: state.localSources.map((s) => RuleSourceEntry(s)).toList(),
      ),
    );
  }
}
