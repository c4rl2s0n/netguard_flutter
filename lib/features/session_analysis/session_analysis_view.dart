import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/widgets/text/text.dart';
import 'package:netguard/netguard.dart';

import 'widgets/session_analysis_scaffold.dart';

class SessionAnalysisView extends StatelessWidget {
  const SessionAnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return _provider(
      BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
        buildWhen: (oldState, state) => oldState.view != state.view,
        builder: (context, state) => SessionAnalysisScaffold(
          Column(
            children: [
              _info(),
              Expanded(child: _body(state.view)),
            ],
          ),
          floatingActionButton: _fab(context, state.view),
        ),
      ),
    );
  }

  Widget _provider(Widget child) =>
      BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
        buildWhen: (oldState, state) =>
            oldState.chartFilterCubit != state.chartFilterCubit,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => SessionLogsFilterCubit(settingsCubit)),
            BlocProvider.value(value: state.chartFilterCubit),
          ],
          child: child,
        ),
      );

  Widget _info() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) =>
          oldState.sessionConfig != state.sessionConfig,
      builder: (context, state) => state.sessionConfig?.observeOnly ?? false
          ? Column(
              children: [
                TWarning(
                  "The firewall is running in observation-mode!\nTraffic is not being filterd!",
                ),
                const Margin.vertical(ThemeConstants.smallSpacing),
              ],
            )
          : SizedBox.shrink(),
    );
  }

  Widget _body(AnalysisView view) => switch (view) {
    AnalysisView.logs => const SessionLogs(),
    AnalysisView.chart => const SessionCharts(),
    // AnalysisView.pie => const SessionPieCharts(),
    // AnalysisView.bar => const SessionBarCharts(),
  };

  Widget? _fab(BuildContext context, AnalysisView view) => switch (view) {
    AnalysisView.logs => SessionLogs.filterDialogButton(context),
    AnalysisView.chart => SessionCharts.filterDialogButton(context),
    // AnalysisView.pie => SessionPieCharts.filterDialogButton(context),
    // AnalysisView.bar => SessionBarCharts.filterDialogButton(context),
  };
}
