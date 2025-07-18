import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/features/settings/global_rules_settings/logic/global_rules_cubit.dart';
import 'package:netguard/features/settings/global_rules_settings/logic/rule_source_entry_cubit.dart';

class RuleSourceEntry extends StatelessWidget {
  const RuleSourceEntry(this.cubit, {super.key});

  final RuleSourceEntryCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<RuleSourceEntryCubit, RuleSourceEntryState>(
        builder: (context, state) => Row(
          children: [
            Expanded(
              child: SimpleTextField(
                initialValue: state.source,
                labelText: switch (state.type) {
                  SourceType.online => "Online source",
                  SourceType.local => "Local source",
                },
                onChanged: cubit.updateSource,
              ),
            ),
            IconButton(
              onPressed: () async =>
                  await ConfirmationDialog.ask(context, title: "Delete source?", content: "Do you really want to delete the ${state.type.name} source?\n${state.source}") && context.mounted
                  ? context.read<GlobalRulesCubit>().removeSource(cubit)
                  : null,
              icon: Icon(CustomIcons.remove, color: context.colors.negative),
            ),
          ],
        ),
      ),
    );
  }
}
