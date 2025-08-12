import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _head(context),
                      if (session.running) ...[
                        TWarning(
                          "These settings will only be effective after restarting the VPN.",
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

  Widget _head(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _lastScanIndication()),
        _clearSourcesBtn(context),
      ],
    );
  }

  Widget _clearSourcesBtn(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (await DeleteConfirmationDialog.ask(
          context,
          title: "Delete Global Rules?",
          content: "Do you want to delete all global firewall rules?",
        )) {
          await globalRuleSourceRepository.clearHashes();
          if(await hostsRepository.clearGeneric() > 0){
            settingsCubit.resetLastHostlistUpdate();
            SnackBarFactory.showPositiveSnackBar("Global firewall rules deleted!");
          }else{
            SnackBarFactory.showInfoSnackBar("No rules found to delete...");
          }
        }
      },
      icon: Icon(CustomIcons.delete, color: context.colors.negative),
    );
  }

  Widget _lastScanIndication() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (oldState, state) =>
          oldState.lastHostlistUpdate != state.lastHostlistUpdate,
      builder: (context, state) {
        TextStyle? style = context.textTheme.bodyLarge;
        return state.lastHostlistUpdate == null
            ? Text(
                "No rules have been scanned!",
                style: style?.copyWith(color: context.colors.warning),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${state.lastHostlistUpdate}\n", style: style),
                  FutureBuilder<int>(
                    future: hostsRepository.getGenericCount(),
                    builder: (context, state) => state.hasData
                        ? Text("${state.data} records")
                        : SizedBox.shrink(),
                  ),
                ],
              );
      },
    );
  }

  Widget _addSourceButton(BuildContext context, SourceType type) {
    return IconButton(
      onPressed: () async {
        var ruleCubit = context.read<GlobalRulesCubit>();
        List<GlobalRuleSource> newSources = switch (type) {
          SourceType.online => await _getOnlineSources(ruleCubit.state),
          SourceType.local => await _getLocalSources(ruleCubit.state),
        };
        ruleCubit.addSources(newSources);
      },
      icon: Icon(CustomIcons.add, color: context.colors.positive),
    );
  }

  Future<List<GlobalRuleSource>> _getOnlineSources(
    GlobalRulesState state,
  ) async {
    if (!await Clipboard.hasStrings()) {
      SnackBarFactory.showNegativeSnackBar("No URL in the clipboard...");
      return [];
    }
    List<String> data =
        (await Clipboard.getData(
          Clipboard.kTextPlain,
        ))?.text?.split("\n").where((l) => l.trim().notEmpty).toList() ??
        [];
    data.removeWhere((d) => state.onlineSources.any((s) => s.source == d));
    int dataNew = data.length;
    if (dataNew <= 0) {
      SnackBarFactory.showNegativeSnackBar(
        "No new URLs found in the clipboard...",
      );
      return [];
    }
    SnackBarFactory.showPositiveSnackBar("Added $dataNew new URLs!");
    return data
        .map((l) => GlobalRuleSource(source: l, type: SourceType.online))
        .toList();
  }

  Future<List<GlobalRuleSource>> _getLocalSources(
    GlobalRulesState state,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: "Select files to scan for hosts",
      allowMultiple: true,
    );

    List<String> files = [];
    if (result != null) {
      files = result.paths.nonNulls.toList();
    }

    if (files.isEmpty) {
      SnackBarFactory.showNegativeSnackBar("No files selected...");
      return [];
    }

    files.removeWhere((d) => state.localSources.any((s) => s.source == d));
    int filesNew = files.length;
    if (filesNew <= 0) {
      SnackBarFactory.showNegativeSnackBar("No new files were selected...");
      return [];
    }
    SnackBarFactory.showPositiveSnackBar("Added $filesNew new files!");
    return files
        .map((l) => GlobalRuleSource(source: l, type: SourceType.local))
        .toList();
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
        action: _addSourceButton(context, SourceType.local),
        info: Text(
          "Specify a list of files that contain hosts or ips to be blocked",
        ),
        settings: state.localSources.map((s) => RuleSourceEntry(s)).toList(),
      ),
    );
  }
}
