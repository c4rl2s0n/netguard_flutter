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
        content: _content(),
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

  Widget _content(){
    return Column(
      children: [
        _searchBar(),
        Flexible(child: _hosts())
      ],
    );
  }
  Widget _searchBar(){
    return BlocBuilder<HostsEditDialogCubit, HostsEditDialogState>(
      buildWhen: (oldState, state) => oldState.search != state.search,
      builder: (context, state) => SimpleTextField(
        initialValue: state.search ?? "",
        labelText: "Search",
        onChanged: context.read<HostsEditDialogCubit>().setSearch,
        onChangedDelay: Duration(milliseconds: 250),
      )
    );
  }
  Widget _hosts() {
    return BlocBuilder<HostsEditDialogCubit, HostsEditDialogState>(
      buildWhen: (oldState, state) =>
          oldState.visibleEntries != state.visibleEntries ||
          oldState.loading != state.loading,
      builder: (context, state) => state.loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children:
                    <Widget>[
                      ...state.visibleEntries.map((e) => HostEditEntry(e)),
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
