import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/netguard.dart';

part 'session_cubit.freezed.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(SettingsCubit settings)
    : super(
        SessionState(
          sessionAnalysis: SessionLogAnalysisCubit(settings),
          sessionStatistics: SessionStatistics(),
        ),
      );

  late final NotificationUpdateService _notificationService =
      NotificationUpdateService(this, vpnController);

  Future load() async {
    await loadApplications();
    SessionStatistics statistics = await packageStatisticsRepository
        .getOverallStatistics(state.applicationsMap.keys.toList());
    emit(
      state.copyWith(
        sessionConfig: await vpnController.getSession(),
        sessionStatistics: statistics,
      ),
    );
  }

  @override
  Future<void> close() async {
    await state.sessionAnalysis.close();
    return super.close();
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
    Settings settings = settingsCubit.state.settings;

    await PermissionTools.requestNotificationPermission();
    await PermissionTools.requestBatteryOptimizationPermission();

    VpnConfig vpnConfig = await VpnTools.getConfig(settings);
    await vpnController.startVpn(vpnConfig);
    trafficLogListener = vpnEventHandler.trafficLog.listen(_onTrafficLog);
    state.sessionAnalysis.clear();
    _notificationService.run();
    emit(state.copyWith(sessionConfig: vpnConfig));
  }

  Future stopVpn() async {
    if (!state.running) return;
    await vpnController.stopVpn();

    _notificationService.stop();
    await trafficLogListener?.cancel();
    trafficLogListener = null;

    emit(state.copyWith(sessionConfig: null));
  }

  void setVpnSession(VpnConfig? session) =>
      emit(state.copyWith(sessionConfig: session));

  void _onTrafficLog(TrafficLog event) {
    state.sessionStatistics.addLog(event);
    state.sessionAnalysis.insert(event, state.applicationsMap);
    state.sessionStatistics.updatePackageInfoFromMap(
      state.sessionAnalysis.state.analysisByApplication.values,
    );
    packageStatisticsRepository.addLog(event);
  }
}

@freezed
class SessionState with _$SessionState {
  const SessionState({
    this.sessionConfig,
    required this.sessionAnalysis,
    this.systemApplicationsMap = const {},
    this.thirdPartyApplicationsMap = const {},
    required this.sessionStatistics,
  });

  @override
  final VpnConfig? sessionConfig;
  @override
  final SessionLogAnalysisCubit sessionAnalysis;
  @override
  final Map<String, Application> systemApplicationsMap;
  @override
  final Map<String, Application> thirdPartyApplicationsMap;

  final SessionStatistics sessionStatistics;

  bool get running => sessionConfig != null;
  bool get hasLogs => sessionAnalysis.hasLogs;

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
