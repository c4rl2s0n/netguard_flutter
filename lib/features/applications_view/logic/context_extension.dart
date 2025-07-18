import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'applications_view_cubit.dart';


extension CtxApplicationsViewCubit on BuildContext {
  ApplicationsViewCubit get applicationsViewCubit =>
      read<ApplicationsViewCubit>();
}
