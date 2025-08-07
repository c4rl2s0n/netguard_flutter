import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/features/features.dart';

class AnalysisNavigation extends StatelessWidget {
  const AnalysisNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.all(ThemeConstants.smallSpacing),
      color: context.colors.primaryContainer.strong,
      shape: CircularNotchedRectangle(),
      notchMargin: 2,
      height: 55,
      child: _contents(context),
    );
  }

  Widget _contents(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...AnalysisView.values.map((v) => _navigationEntry(context, v)),
        //SizedBox.shrink()
      ],
    );
  }

  Widget _navigationEntry(BuildContext context, AnalysisView view) {
    return BlocBuilder<SessionLogAnalysisCubit, SessionLogAnalysisState>(
      buildWhen: (oldState, state) => oldState.view != state.view,
      builder: (context, state) {
        bool selected = state.view == view;
        return IconButton(
          onPressed: () =>
              context.read<SessionLogAnalysisCubit>().setView(view),
          icon: Icon(_viewIcon(view)),
          isSelected: selected,

          style: (context.themeData.iconButtonTheme.style??ButtonStyle()).copyWith(
            foregroundColor: WidgetStateProperty.fromMap({
              WidgetState.selected: context.colors.primaryContainer,
              WidgetState.any: context.colors.onPrimaryContainer.medium,
            }),
            backgroundColor: WidgetStateProperty.fromMap({
              WidgetState.selected: context.colors.onPrimaryContainer.withAlpha(Color.getAlphaFromOpacity(0.8)),
              WidgetState.any: Colors.transparent,
            }),
          ),
        );
      },
    );
  }

  IconData _viewIcon(AnalysisView view) => switch (view) {
    AnalysisView.logs => CustomIcons.logs,
    AnalysisView.chart => CustomIcons.bar,
    // AnalysisView.pie => CustomIcons.pie,
    // AnalysisView.bar => CustomIcons.bar,
  };
}
