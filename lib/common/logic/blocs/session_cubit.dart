import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

part 'session_cubit.freezed.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(SessionState());

  Future load()async{
    await loadApplications();
    emit(state.copyWith(running: await vpnController.isRunning()));
  }

  Future loadApplications() async {
    List<Application> applications = await vpnController.getApplications();

    for (var app in applications) {
      ApplicationSetting? setting = await applicationSettingsRepository
          .getForPackage(app.packageName);
      if (setting == null) {
        setting = ApplicationSetting(
          packageName: app.packageName,
          // by default, do not filter system applications
          filter: !app.system,
        );
        await applicationSettingsRepository.insert(setting);
      }
      app.setting = setting;
      emit(
        state.copyWith(
          systemApplications: applications.where((a) => a.system).toList(),
          thirdPartyApplications: applications.where((a) => !a.system).toList(),
        ),
      );
    }
  }


  Future startVpn() async {
    if (state.running) return;
    PermissionTools.requestNotificationPermission();
    PermissionTools.requestBatteryOptimizationPermission();

    await vpnController.startVpn(await VpnTools.getConfig());
    emit(state.copyWith(running: true));
  }

  Future stopVpn() async {
    if (!state.running) return;
    await vpnController.stopVpn();
    emit(state.copyWith(running: false));
  }

  void setVpnState(bool running) => emit(state.copyWith(running: running));
}

@freezed
class SessionState with _$SessionState {
  const SessionState({
    this.running = false,
    this.systemApplications = const [],
    this.thirdPartyApplications = const [],
  });

  @override
  final bool running;
  @override
  final List<Application> systemApplications;
  @override
  final List<Application> thirdPartyApplications;

  List<Application> get applications => [
    ...thirdPartyApplications,
    ...systemApplications,
  ];
}
