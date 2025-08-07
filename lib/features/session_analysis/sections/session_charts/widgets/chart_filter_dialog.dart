import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/netguard.dart';

import '../logic/session_chart_filter_cubit.dart';

class ChartFilterDialog extends StatelessWidget {
  const ChartFilterDialog(this.filterCubit, {super.key});

  final SessionChartFilterCubit filterCubit;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "Chart Filter",
      icon: const Icon(CustomIcons.filter),
      content: BlocProvider.value(
        value: filterCubit,
        child: Column(
          children:
              [
                _filterApplication(),
                const VolumeTypeSetting(),
                _sorting(),
                _chartType(),
                _singleBar(),
                _groupType(),
              ].insertBetweenItems(
                () => const Margin.vertical(ThemeConstants.spacing),
              ),
        ),
      ),
      actions: const [ConfirmButton()],
    );
  }

  Widget _filterApplication() {
    return BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
      buildWhen: (oldState, state) =>
          oldState.filterApplications != state.filterApplications,
      builder: (context, state) => ApplicationFilterSetting(
        initialSelection: state.filterApplications,
        onSelectionChanged: filterCubit.setFilterApplications,
      ),
    );
  }

  Widget _sorting() {
    return BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
      buildWhen: (oldState, state) => oldState.sorting != state.sorting,
      builder: (context, state) => SortingSetting(
        selected: state.sorting,
        options: [
          LogSorting.name,
          LogSorting.time,
          LogSorting.volume,
          LogSorting.blockedVolume,
        ],
        onChanged: filterCubit.setSorting,
      ),
    );
  }

  Widget _chartType() {
    return BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
      buildWhen: (oldState, state) => oldState.chartType != state.chartType,
      builder: (context, state) => SimpleSetting(
        name: "Chart Type",
        //description: "Show traffic volume in count of bytes",
        action: DropdownMenu<ChartType>(
          initialSelection: state.chartType,
          requestFocusOnTap: false,
          onSelected: (v) => v != null ? filterCubit.setChartType(v) : null,
          dropdownMenuEntries: ChartType.values
              .map(
                (d) =>
                    DropdownMenuEntry<ChartType>(value: d, label: d.toString()),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _singleBar() {
    return BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
      buildWhen: (oldState, state) => oldState.singleBar != state.singleBar || oldState.chartType != state.chartType,
      builder: (context, state) => SwitchSetting(
        name: "Single Bar",
        description: "Show allowed and blocked in a single bar",
        value: state.singleBar,
        enabled: state.chartType == ChartType.bar,
        onChanged: filterCubit.setSingleBar,
      ),
    );
  }

  Widget _groupType() {
    return BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
      buildWhen: (oldState, state) => oldState.groupType != state.groupType,
      builder: (context, state) => SimpleSetting(
        name: "Group Type",
        description: "How to group the traffic in the charts",
        action: DropdownMenu<GroupType>(
          initialSelection: state.groupType,
          requestFocusOnTap: false,
          onSelected: (v) => v != null ? filterCubit.setGroupType(v) : null,
          dropdownMenuEntries: GroupType.values
              .map(
                (d) =>
                DropdownMenuEntry<GroupType>(value: d, label: d.toString()),
          )
              .toList(),
        ),
      ),
    );
  }

  static Future show(
    BuildContext context,
    SessionChartFilterCubit filterCubit,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ChartFilterDialog(filterCubit),
    );
    if(context.mounted){
      context.analysisCubit.reSort();
    }
  }
}
