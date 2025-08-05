import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/features/applications_view/application_view/logic/hosts_edit_dialog_cubit.dart';
import 'package:netguard/features/applications_view/application_view/widgets/host_edit_entry.dart';

class HostsEditDialog extends StatelessWidget {
  const HostsEditDialog({required this.rule, super.key});

  final Rule rule;
  String get title => rule.name.empty ? "Edit Rule" : rule.name!;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HostsEditDialogCubit(rule),
      child: CustomDialog(
        title: title,
        icon: Icon(CustomIcons.edit),
        content: _hosts(),
        actions: [_cancel(), _confirm()],
      ),
    );
  }

  Widget _cancel() {
    return DeclineButton(text: "Cancel", returnValue: null);
  }

  Widget _confirm() {
    return BlocBuilder<HostsEditDialogCubit, HostsEditDialogState>(
      builder: (context, state) => ConfirmButton(
        text: "Done",
        returnValue: state.entries
            .where((e) => e.state.selected)
            .map((e) => e.state.entry),
      ),
    );
  }

  Widget _hosts() {
    return BlocBuilder<HostsEditDialogCubit, HostsEditDialogState>(
      buildWhen: (oldState, state) =>
          oldState.entries != state.entries ||
          oldState.loading != state.loading,
      builder: (context, state) => state.loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children:
                    <Widget>[
                      Todo("sometimes only hosts or ips visible?"),
                      ...state.entries.map((e) => HostEditEntry(e)),
                    ].insertBetweenItems(
                      () => const Margin.vertical(ThemeConstants.smallSpacing),
                    ),
              ),
            ),
    );
  }

  static Future<Iterable<HostEntry>?> show(
    BuildContext context, {
    required Rule rule,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => HostsEditDialog(rule: rule),
    );
  }
}
