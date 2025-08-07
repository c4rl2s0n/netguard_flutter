import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/features/applications_view/application_view/application_view.dart';
import 'package:netguard/features/applications_view/logic/application_entry_cubit.dart';

class ApplicationEntry extends StatelessWidget {
  const ApplicationEntry(this.applicationCubit, {super.key});

  final ApplicationEntryCubit applicationCubit;
  Application get application => applicationCubit.state.app;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: applicationCubit,
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return BlocBuilder<ApplicationEntryCubit, ApplicationEntryState>(
      buildWhen: (oldState, state) => oldState.filter != state.filter,
      builder: (context, state) => ActionSetting(
        name: application.label,
        //subtitle: Text(application.packageName),
        description: "${application.packageName}\n${application.version}",
        leading: SizedBox.square(
          dimension: 42,
          child: application.icon != null
              ? Image.memory(application.icon!)
              : null,
        ),
        trailing: Switch(
          value: state.filter,
          onChanged: applicationCubit.setFilter,
        ),
        action: state.filter
            ? (context) => context.navigator.navigateTo(
                ApplicationView(applicationCubit),
              )
            : null,
      ),
    );
  }
}
