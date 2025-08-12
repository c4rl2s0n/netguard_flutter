import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/features/settings/global_rules_settings/logic/global_rules_cubit.dart';

class RuleSourceEntry extends StatelessWidget {
  const RuleSourceEntry(this.source, {super.key});

  final GlobalRuleSource source;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(source.source)),
        IconButton(
          onPressed: () => _deleteSource(context),
          icon: Icon(CustomIcons.remove, color: context.colors.negative),
        ),
      ],
    );
  }

  Future _deleteSource(BuildContext context) async {
    if (await DeleteConfirmationDialog.ask(
              context,
              title: "Delete source?",
              content:
                  "Do you really want to delete the ${source.type.name} source?\n${source.source}",
            ) &&
            context.mounted) {
      context.read<GlobalRulesCubit>().removeSource(source);
    }
  }
}
