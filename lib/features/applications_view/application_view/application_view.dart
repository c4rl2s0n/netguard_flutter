import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/applications_view/application_view/widgets/rule_view.dart';
import 'package:netguard/features/applications_view/logic/application_entry_cubit.dart';
import 'package:netguard/netguard.dart';

class ApplicationView extends StatelessWidget {
  const ApplicationView(this.applicationCubit, {super.key});

  final ApplicationEntryCubit applicationCubit;
  Application get app => applicationCubit.state.app;

  @override
  Widget build(BuildContext context) {
    return OnLeaveUpdater(
      update: (_) async => await applicationCubit.store(),
      child: BlocProvider.value(
        value: applicationCubit,
        child: PageComponentFactory.scaffold(
          context,
          appBar: PageComponentFactory.appBar(
            context,
            title: app.label,
            actions: [PageComponentFactory.settingsNavigationButton(context)],
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<ApplicationEntryCubit, ApplicationEntryState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              [
                _generic(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [...state.rules.map((r) => RuleView(r))],
                    ),
                  ),
                ),
              ].insertBetweenItems(
                () => const Margin.vertical(ThemeConstants.spacing),
              ),
        );
      },
    );
  }

  Widget _generic(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.primary),
        borderRadius: ThemeConstants.borderRadius,
      ),
      padding: const EdgeInsets.all(ThemeConstants.spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_newRule(), _blockAll(), _sessionRunningInfo()],
      ),
    );
  }

  Widget _newRule() {
    return ActionSetting(
      name: "New Rule",
      action: (_) => applicationCubit.createRule(),
      trailing: Icon(CustomIcons.add),
    );
  }

  Widget _blockAll() {
    return BlocBuilder<ApplicationEntryCubit, ApplicationEntryState>(
      buildWhen: (oldState, state) => oldState.blockAll != state.blockAll,
      builder: (context, state) => SwitchSetting(
        name: "Block all traffic",
        description:
            "When set, all traffic is blocked, ignoring any specified rules",
        value: state.blockAll,
        onChanged: context.read<ApplicationEntryCubit>().setBlockAll,
      ),
    );
  }

  Widget _sessionRunningInfo() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) => oldState.running != state.running,
      builder: (context, state) => state.running
          ? Text(
              "In order to modify these settings, you need to turn off the Firewall",
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colors.warning,
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
