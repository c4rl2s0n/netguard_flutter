import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

part 'session_cubit.freezed.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(SessionState());

  Future load() async {
    await loadApplications();
    emit(state.copyWith(sessionId: await vpnController.getSession()));
  }

  Future loadApplications() async {
    List<Application> applications = (await vpnController.getApplications())
        .map((a) => Application.fromNative(a))
        .toList();

    for (var app in applications) {
      // load current settings for the application
      app.setting = await _loadAppSettings(app);

      // load rules for the application
      app.rules = await rulesRepository.getForPackage(app.packageName);
    }

    Map<String, Application> systemApplicationsMap = {
      for (Application app in applications.where((a) => a.system))
        app.packageName: app,
    };
    Map<String, Application> thirdPartyApplicationsMap = {
      for (Application app in applications.where((a) => !a.system))
        app.packageName: app,
    };
    emit(
      state.copyWith(
        systemApplicationsMap: systemApplicationsMap,
        thirdPartyApplicationsMap: thirdPartyApplicationsMap,
      ),
    );
  }

  Future<ApplicationSetting> _loadAppSettings(Application app) async {
    ApplicationSetting? setting = await applicationSettingsRepository
        .getForPackage(app.packageName);
    if (setting == null) {
      setting = ApplicationSetting(
        packageName: app.packageName,
        // by default, do not filter system applications
        filter: !app.system,
        blockAll: false,
      );
      await applicationSettingsRepository.insert(setting);
    }
    return setting;
  }

  StreamSubscription? trafficLogListener;

  Future startVpn() async {
    if (state.running) return;
    await PermissionTools.requestNotificationPermission();
    await PermissionTools.requestBatteryOptimizationPermission();

    VpnConfig vpnConfig = await VpnTools.getConfig();
    await vpnController.startVpn(vpnConfig);
    trafficLogListener = vpnEventHandler.trafficLog.listen(_onTrafficLog);
    emit(state.copyWith(sessionId: vpnConfig.session, sessionTrafficLog: []));
  }

  Future stopVpn() async {
    if (!state.running) return;
    await vpnController.stopVpn();
    await trafficLogListener?.cancel();
    emit(state.copyWith(sessionId: null));
  }

  void setVpnSession(String? sessionId) =>
      emit(state.copyWith(sessionId: sessionId));

  void _onTrafficLog(TrafficLog event) {
    emit(
      state.copyWith(sessionTrafficLog: [event, ...state.sessionTrafficLog]),
    );
  }
}

@freezed
class SessionState with _$SessionState {
  const SessionState({
    this.sessionId,
    this.sessionTrafficLog = const [],
    this.systemApplicationsMap = const {},
    this.thirdPartyApplicationsMap = const {},
  });

  @override
  final String? sessionId;
  @override
  final List<TrafficLog> sessionTrafficLog;
  @override
  final Map<String, Application> systemApplicationsMap;
  @override
  final Map<String, Application> thirdPartyApplicationsMap;

  bool get running => sessionId.notEmpty;

  Map<String, Application> get applicationsMap => {
    ...thirdPartyApplicationsMap,
    ...systemApplicationsMap,
  };
  List<Application> get systemApplications =>
      systemApplicationsMap.values.toList();
  List<Application> get thirdPartyApplications =>
      thirdPartyApplicationsMap.values.toList();
  List<Application> get applications => [
    ...systemApplications,
    ...thirdPartyApplications,
  ];
}
