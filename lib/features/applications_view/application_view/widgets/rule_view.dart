import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/applications_view/application_view/widgets/hosts_edit_dialog.dart';
import 'package:netguard/features/applications_view/logic/application_entry_cubit.dart';
import 'package:netguard/netguard.dart';

import '../logic/rule_cubit.dart';

class RuleView extends StatelessWidget {
  const RuleView(this.ruleCubit, {super.key});

  final RuleCubit ruleCubit;
  RuleState get rule => ruleCubit.state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      key: Key(rule.id),
      value: ruleCubit,
      child: _ruleExpander(context),
    );
  }

  Widget _ruleExpander(BuildContext context) {
    return BlocBuilder<RuleCubit, RuleState>(
      buildWhen: (oldState, state) =>
          oldState.name != state.name ||
          oldState.hosts != state.hosts ||
          oldState.ips != state.ips,
      builder: (context, state) => ExpanderEdit(
        key: Key(rule.id),
        title: state.name ?? "",
        subtitle: _ruleSubtitle(state),
        showSubtitleOnEdit: true,
        onTitleChanged: ruleCubit.setName,
        buildLeading: (context, expanded) =>
            expanded ? Icon(Icons.keyboard_arrow_up) : null,
        trailing: _active(),
        child: _ruleEditView(context),
      ),
    );
  }

  String _ruleSubtitle(RuleState state) {
    String hosts =
        "${state.hosts.isEmpty && state.type == RuleType.whitelist ? "all" : state.hosts.length} hosts";
    String ips =
        "${state.ips.isEmpty && state.type == RuleType.whitelist ? "all" : state.ips.length} IPs";

    return "$hosts, $ips ${switch (state.type) {
      RuleType.blacklist => "blocked",
      RuleType.whitelist => "allowed",
    }}";
  }

  Widget _active() {
    return BlocBuilder<RuleCubit, RuleState>(
      buildWhen: (oldState, state) => oldState.active != state.active,
      builder: (context, state) =>
          Switch(value: state.active, onChanged: ruleCubit.setActive),
    );
  }

  Widget _ruleEditView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _description(),
        _ruleType(),
        _hosts(),
        _deleteBtn(context),
      ].insertBetweenItems(() => const Margin.vertical(ThemeConstants.spacing)),
    );
  }

  Widget _description() {
    return Column(
      children: [
        BlocBuilder<RuleCubit, RuleState>(
          buildWhen: (oldState, state) =>
              oldState.description != state.description,
          builder: (context, state) => SimpleTextField(
            initialValue: state.description ?? "",
            labelText: "Rule Description",
            maxLines: 4,
            onChanged: ruleCubit.setDescription,
            onChangedDelay: Duration(seconds: 2),
          ),
        ),
        BlocBuilder<RuleCubit, RuleState>(
          buildWhen: (oldState, state) =>
              oldState.shouldBlockQuic != state.shouldBlockQuic,
          builder: (context, state) => state.shouldBlockQuic
              ? TInfo("This rule suggests to block QUIC for this application")
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _ruleType() {
    Widget labelWidget(RuleType type) => Container(
      width: 20,
      height: 20,
      decoration: type == RuleType.whitelist
          ? BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
            )
          : BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.black,
            ),
    );
    return BlocBuilder<RuleCubit, RuleState>(
      buildWhen: (oldState, state) => oldState.type != state.type,
      builder: (context, state) => Column(
        children: [
          SimpleSetting(
            name: "Type (${state.type.name})",
            description: "Type of the rule",
            action: DropdownMenu<RuleType>(
              key: Key(state.type.name),
              initialSelection: state.type,
              requestFocusOnTap: false,
              leadingIcon: Row(
                children: [Expanded(child: labelWidget(state.type))],
              ),
              onSelected: (t) => t != null ? ruleCubit.setType(t) : null,
              dropdownMenuEntries: RuleType.values
                  .map(
                    (d) => DropdownMenuEntry<RuleType>(
                      value: d,
                      label: d.name,
                      leadingIcon: labelWidget(d),
                      //labelWidget: labelWidget(d),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (state.type == RuleType.whitelist) _whitelistExclusive(),
        ],
      ),
    );
  }

  Widget _whitelistExclusive() {
    return BlocBuilder<RuleCubit, RuleState>(
      builder: (context, state) => SwitchSetting(
        name: "Whitelist Exclusive",
        description: "If true, only entries from the whitelist will be allowed",
        value: state.whitelistExclusive,
        onChanged: ruleCubit.setWhitelistExclusive,
      ),
    );
  }

  Widget _hosts() {
    return BlocBuilder<RuleCubit, RuleState>(
      buildWhen: (oldState, state) =>
          oldState.hosts != state.hosts || oldState.ips != state.ips,
      builder: (context, state) => ActionSetting(
        name: "Hosts / IPs",
        description: _hostsInfo(state),
        trailing: Icon(CustomIcons.edit),
        action: (context) async {
          Iterable<HostEntry>? newEntries = await HostsEditDialog.show(
            context,
            rule: rule.rule,
          );
          if (newEntries != null && context.mounted) {
            ruleCubit.setHosts(newEntries);
          }
        },
      ),
    );
  }

  String _hostsInfo(RuleState state) {
    String hosts = "${state.hosts.length} hosts";
    String ips = "${state.ips.length} IPs";
    return "$hosts, $ips";
  }

  Widget _deleteBtn(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconTextButton(
        icon: Icon(CustomIcons.remove),
        text: "Delete",
        color: context.colors.negative,
        onTap: () async {
          if (await DeleteConfirmationDialog.ask(
                context,
                title: "Delete Firewall Rule?",
                content: "Do you want to delete the rule '${rule.name}'?",
              ) &&
              context.mounted) {
            context.read<ApplicationEntryCubit>().deleteRule(ruleCubit);
          }
        },
      ),
    );
  }
}
