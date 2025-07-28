import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/features/session_logs/logic/session_logs_filter_cubit.dart';

import '../../../data/models/application.dart';

class LogFilterDialog extends StatelessWidget {
  const LogFilterDialog(this.filterCubit, {super.key});

  final SessionLogsFilterCubit filterCubit;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "Log Filter",
      icon: const Icon(CustomIcons.filter),
      content: BlocProvider.value(
        value: filterCubit,
        child: SingleChildScrollView(
          child: Column(
            children:
                [
                  _showGrouped(),
                  _blockedOnly(),
                  _allowedOnly(),
                  _filterApplication(),
                ].insertBetweenItems(
                  () => const Margin.vertical(ThemeConstants.spacing),
                ),
          ),
        ),
      ),
      actions: const [ConfirmButton()],
      expand: false,
    );
  }

  Widget _showGrouped() {
    return BlocBuilder<SessionLogsFilterCubit, SessionLogsFilterState>(
      buildWhen: (oldState, state) => oldState.showGrouped != state.showGrouped,
      builder: (context, state) => Column(
        children: [
          SwitchSetting(
            name: "Compact view",
            description: "Group logs by Application, Destination, Protocol",
            value: state.showGrouped,
            onChanged: filterCubit.setShowGrouped,
          ),
          if (state.showGrouped) ...[
            const Margin.vertical(ThemeConstants.spacing),
            _sorting(),
          ],
        ],
      ),
    );
  }

  Widget _blockedOnly() {
    return BlocBuilder<SessionLogsFilterCubit, SessionLogsFilterState>(
      buildWhen: (oldState, state) => oldState.blockedOnly != state.blockedOnly,
      builder: (context, state) => SwitchSetting(
        name: "Only blocked connections",
        description: "Show only connections that were blocked by the firewall",
        value: state.blockedOnly,
        onChanged: filterCubit.setBlockedOnly,
      ),
    );
  }

  Widget _allowedOnly() {
    return BlocBuilder<SessionLogsFilterCubit, SessionLogsFilterState>(
      buildWhen: (oldState, state) => oldState.allowedOnly != state.allowedOnly,
      builder: (context, state) => SwitchSetting(
        name: "Only allowed connections",
        description: "Show only connections that were allowed by the firewall",
        value: state.allowedOnly,
        onChanged: filterCubit.setAllowedOnly,
      ),
    );
  }

  Widget _filterApplication() {
    return BlocBuilder<SessionLogsFilterCubit, SessionLogsFilterState>(
      buildWhen: (oldState, state) =>
          oldState.filterApplication != state.filterApplication,
      builder: (context, state) {
        return SimpleSetting(
          name: "Application filter",
          description: "Show only the selected application",
          action: DropdownMenu<String>(
            key: Key("FilterApplication${state.filterApplication ?? ""}"),
            initialSelection: state.filterApplication,
            requestFocusOnTap: false,
            onSelected: (v) =>
                v != null ? filterCubit.setFilterApplication(v) : null,
            dropdownMenuEntries:
                [
                      FilterStrings.all,
                      FilterStrings.unknown,
                      ...sessionCubit.state.applications.where(
                        (a) => a.setting?.filter ?? false,
                      ),
                    ]
                    .map(
                      (d) => DropdownMenuEntry<String>(
                        value: d is Application ? d.packageName : d.toString(),
                        label: d is Application ? d.label : d.toString(),
                        leadingIcon: SizedBox.square(
                          dimension: 24,
                          child: d is Application
                              ? d.image
                              : d == FilterStrings.unknown
                              ? Icon(CustomIcons.question)
                              : null,
                        ),
                      ),
                    )
                    .toList(),
          ),
        );
      },
    );
  }

  Widget _sorting() {
    return BlocBuilder<SessionLogsFilterCubit, SessionLogsFilterState>(
      buildWhen: (oldState, state) =>
          oldState.showGrouped != state.showGrouped ||
          oldState.sorting != state.sorting,
      builder: (context, state) {
        return state.showGrouped
            ? SimpleSetting(
                name: "Log sorting",
                description: "How to sort the logs",
                action: DropdownMenu<LogSorting>(
                  key: Key("LogSorting${state.sorting}"),
                  initialSelection: state.sorting,
                  requestFocusOnTap: false,
                  onSelected: (v) =>
                      v != null ? filterCubit.setSorting(v) : null,
                  dropdownMenuEntries: LogSorting.values
                      .map(
                        (d) => DropdownMenuEntry<LogSorting>(
                          value: d,
                          label: d.name,
                        ),
                      )
                      .toList(),
                ),
              )
            : SizedBox.shrink();
      },
    );
  }

  static Future show(
    BuildContext context,
    SessionLogsFilterCubit filterCubit,
  ) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => LogFilterDialog(filterCubit),
    );
  }
}
