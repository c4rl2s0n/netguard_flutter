import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/models/host_entry.dart';
import 'package:netguard/features/applications_view/application_view/logic/hosts_edit_dialog_cubit.dart';

import '../logic/hosts_edit_entry_cubit.dart';

class HostEditEntry extends StatelessWidget {
  const HostEditEntry(this.entryCubit, {super.key});

  final HostsEditEntryCubit entryCubit;
  HostEntry get entry => entryCubit.state.entry;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: entryCubit,
      child: BlocBuilder<HostsEditDialogCubit, HostsEditDialogState>(
        buildWhen: (oldState, state) => oldState.rule != state.rule,
        builder: (context, dialogState) =>
            BlocBuilder<HostsEditEntryCubit, HostsEditEntryState>(
              buildWhen: (oldState, state) =>
                  oldState.selected != state.selected,
              builder: (context, entryState) =>
                  ActionSetting(
                    name: entry.target,
                    action: (_) => entryCubit.toggleSelection(),
                    trailing: Icon(
                      entryState.selected
                          ? CustomIcons.checkboxSelected
                          : CustomIcons.checkboxDeselected,
                    ),
                  ).withBorder(
                    color: _borderColor(
                      context,
                      entryState,
                      dialogState.rule.type,
                    ),
                    padding: EdgeInsets.zero,
                  ),
            ),
      ),
    );
  }

  Color _borderColor(
    BuildContext context,
    HostsEditEntryState state,
    RuleType ruleType,
  ) {
    return state.selected
        ? switch (ruleType) {
            RuleType.blacklist => context.colors.negative,
            RuleType.whitelist => context.colors.positive,
          }
        : Colors.transparent;
  }
}
