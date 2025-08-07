import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

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
        child: Column(
          children:
              [
                _filterApplication(),
                _showGrouped(),
                _sorting(),
                _blockedOnly(),
                _allowedOnly(),
                const VolumeTypeSetting(),
              ].insertBetweenItems(
                () => const Margin.vertical(ThemeConstants.spacing),
              ),
        ),
      ),
      actions: const [ConfirmButton()],
    );
  }

  Widget _showGrouped() {
    return BlocBuilder<SessionLogsFilterCubit, SessionLogsFilterState>(
      buildWhen: (oldState, state) => oldState.showGrouped != state.showGrouped,
      builder: (context, state) => SwitchSetting(
        name: "Compact view",
        description: "Group logs by Application, Destination, Protocol",
        value: state.showGrouped,
        onChanged: filterCubit.setShowGrouped,
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
          oldState.filterApplications != state.filterApplications,
      builder: (context, state) => ApplicationFilterSetting(
        initialSelection: state.filterApplications,
        onSelectionChanged: filterCubit.setFilterApplications,
      ),
    );
  }

  Widget _sorting() {
    return BlocBuilder<SessionLogsFilterCubit, SessionLogsFilterState>(
      buildWhen: (oldState, state) =>
          oldState.showGrouped != state.showGrouped ||
          oldState.sorting != state.sorting,
      builder: (context, filter) =>
          BlocListener<SessionLogAnalysisCubit, SessionLogAnalysisState>(
            listenWhen: (oldState, state) =>
                !filter.showGrouped &&
                filter.sorting == LogSorting.volume &&
                oldState.volumeType != state.volumeType &&
                state.volumeType == VolumeType.count,
            listener: (context, state) =>
                filterCubit.setSorting(LogSorting.time),
            child: SortingSetting(
              enabled: filter.showGrouped,
              selected: filter.sorting,
              options: [
                LogSorting.time,
                if (filter.showGrouped) LogSorting.volume,
                LogSorting.name,
                LogSorting.application,
              ],
              onChanged: filterCubit.setSorting,
            ),
          ),
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
