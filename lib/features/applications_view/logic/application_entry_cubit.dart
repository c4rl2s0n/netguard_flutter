import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/native/native_bridge.g.dart';
import 'package:netguard/common/service_locator/accessors.dart';
import 'package:netguard/data/data.dart';

part 'application_entry_cubit.freezed.dart';

class ApplicationEntryCubit extends Cubit<ApplicationEntryState> {
  ApplicationEntryCubit(Application application, ApplicationSetting entry)
    : super(ApplicationEntryState.fromModels(application, entry));

  void toggleFilter() {
    emit(state.copyWith(filter: !state.filter));
    applicationSettingsRepository.insert(state.setting);
  }
  void setFilter(bool filter) {
    emit(state.copyWith(filter: filter));
    applicationSettingsRepository.insert(state.setting);
  }
}

@freezed
class ApplicationEntryState with _$ApplicationEntryState {
  const ApplicationEntryState({
    required this.app,
    required this.filter,
  });
  ApplicationEntryState.fromModels(Application app, ApplicationSetting setting)
    : this(
        app: app,
        filter: setting.filter,
      );
  final Application app;
  @override
  final bool filter;

  ApplicationSetting get setting =>
      ApplicationSetting(packageName: app.packageName, filter: filter);
}
