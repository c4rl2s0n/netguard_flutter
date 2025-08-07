import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/features/session_analysis/session_analysis.dart';
import 'package:netguard/data/data.dart';

class TapToAppLogs extends StatelessWidget {
  const TapToAppLogs({
    required this.application,
    required this.child,
    super.key,
  });

  final Widget child;
  final Application? application;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var logsFilterCubit = context.read<SessionLogsFilterCubit>();
        logsFilterCubit.setFilterApplications([application]);
        logsFilterCubit.setAllowedOnly(false);
        logsFilterCubit.setBlockedOnly(false);
        context.read<SessionLogAnalysisCubit>().setView(AnalysisView.logs);
      },
      child: child,
    );
  }
}
