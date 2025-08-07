import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/session_analysis/sections/session_charts/widgets/bar_view.dart';
import 'package:netguard/netguard.dart';

import 'widgets/chart_filter_dialog.dart';
import 'widgets/pie_view.dart';

class SessionCharts extends StatelessWidget {
  const SessionCharts({super.key});

  static Widget filterDialogButton(BuildContext context) {
    return AnalysisFloatingActionButton(
      child: Icon(CustomIcons.filter),
      onPressed: () => ChartFilterDialog.show(
        context,
        context.read<SessionChartFilterCubit>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _charts()),
        const Margin.vertical(ThemeConstants.spacing),
        AnalysisColorLegend.colorOnly(context),
      ],
    );
  }

  Widget _charts() {
    return MultiBlocListener(
      listeners: [
        BlocListener<SessionLogAnalysisCubit, SessionLogAnalysisState>(
          listenWhen: (oldState, state) => oldState.logs != state.logs,
          listener: (context, state) => context.analysisCubit.maybeSort(),
        ),
        BlocListener<SessionLogAnalysisCubit, SessionLogAnalysisState>(
          listenWhen: (oldState, state) =>
              oldState.volumeType != state.volumeType,
          listener: (context, state) =>
              context.analysisCubit.reSort(),
        ),
        BlocListener<SessionChartFilterCubit, SessionChartFilterState>(
          listenWhen: (oldState, state) =>
              oldState.sorting != state.sorting ||
              oldState.filterApplications != state.filterApplications,
          listener: (context, state) =>
              context.analysisCubit.reSort(),
        ),
      ],
      child: BlocBuilder<SessionChartFilterCubit, SessionChartFilterState>(
        buildWhen: (oldState, state) => oldState.chartType != state.chartType,
        builder: (context, filter) => SingleChildScrollView(
          child: switch (filter.chartType) {
            ChartType.bar => const BarView(),
            ChartType.pie => const PieView(),
          },
        ),
      ),
    );
  }
}
