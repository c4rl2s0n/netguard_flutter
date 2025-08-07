
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'session_log_analysis_cubit.dart';
extension SessionAnalysisCubitExt on BuildContext{
  SessionLogAnalysisCubit get analysisCubit => read<SessionLogAnalysisCubit>();
}
