import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

import 'logic/logic.dart';
import 'widgets/widgets.dart';

class ApplicationsView extends StatelessWidget {
  const ApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(
        context,
        title: "Applications",
        actions: [PageComponentFactory.settingsNavigationButton(context)],
      ),
      body: BlocProvider(
        create: (context) => ApplicationsViewCubit(),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<ApplicationsViewCubit, ApplicationsViewState>(
      builder: (context, state) {
        return BlocBuilder<SessionCubit, SessionState>(
          buildWhen: (oldState, state) => oldState.running != state.running,
          builder: (context, session) =>
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (oldState, state) =>
                    oldState.includeSystemApps != state.includeSystemApps,
                builder: (context, settings) => SingleChildScrollView(
                  child: Column(
                    children: [
                      if (session.running) _sessionRunningInfo(context),
                      _thirdPartyApps(!session.running),
                      if (settings.includeSystemApps) ...[
                        const Margin.vertical(ThemeConstants.spacing),
                        _systemApps(!session.running),
                      ],
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }

  Widget _sessionRunningInfo(BuildContext context) {
    return Text(
      "In order to modify these settings, you need to turn off the Firewall",
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colors.warning,
      ),
    );
  }

  Widget _thirdPartyApps(bool canEdit) {
    return BlocBuilder<ApplicationsViewCubit, ApplicationsViewState>(
      buildWhen: (oldState, state) =>
          oldState.thirdPartyEntries != state.thirdPartyEntries,
      builder: (context, state) => _group(
        context,
        "3rd Party Applications",
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.thirdPartyEntries.length,
          itemBuilder: (context, i) =>
              ApplicationEntry(state.thirdPartyEntries[i]),
        ),
        groupAction: BlocBuilder<ApplicationsViewCubit, ApplicationsViewState>(
          buildWhen: (oldState, state) =>
              oldState.thirdPartyAllEnabled != state.thirdPartyAllEnabled,
          builder: (context, state) =>
              _groupAction(context, state.thirdPartyEntries, canEdit),
        ),
      ),
    );
  }

  Widget _systemApps(bool canEdit) {
    return BlocBuilder<ApplicationsViewCubit, ApplicationsViewState>(
      buildWhen: (oldState, state) =>
          oldState.systemEntries != state.systemEntries,
      builder: (context, state) => _group(
        context,
        "System Applications",
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.systemEntries.length,
          itemBuilder: (context, i) {
            return ApplicationEntry(state.systemEntries[i]);
          },
        ),
        groupAction: BlocBuilder<ApplicationsViewCubit, ApplicationsViewState>(
          buildWhen: (oldState, state) =>
              oldState.systemAllEnabled != state.systemAllEnabled,
          builder: (context, state) =>
              _groupAction(context, state.systemEntries, canEdit),
        ),
      ),
    );
  }

  Widget _groupAction(
    BuildContext context,
    List<ApplicationEntryCubit> affectedEntries,
    bool canEdit,
  ) {
    return Switch(
      value: affectedEntries.every((e) => e.state.filter),
      onChanged: canEdit
          ? (v) => context.applicationsViewCubit.setFilterForAll(
              affectedEntries,
              v,
            )
          : null,
    );
  }

  Widget _group(
    BuildContext context,
    String title,
    Widget child, {
    Widget? groupAction,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: context.textTheme.titleLarge)),
            if (groupAction != null) groupAction,
          ],
        ),
        child,
      ],
    );
  }
}
