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
      NotificationUpdateService(stream, vpnController);

  Future load() async {
    await loadApplications();
    VpnConfig? session = await vpnController.getSession();
    SessionStatistics sessionStatistics;
    if(session != null && !session.finished){
      // load statistics of active session
      sessionStatistics = await _attachToSession(session: session);
    } else {
      // load all-time statistics
      sessionStatistics = await loadGlobalStatistics();
    }
    emit(
      state.copyWith(
        sessionConfig: session,
        sessionStatistics: sessionStatistics,
      ),
    );
  }

  @override
  Future<void> close() async {
    await state.sessionAnalysis.close();
    return super.close();
  }

  Future<SessionStatistics> loadGlobalStatistics() async {
    return await trafficStatisticsRepository.getPackageStatistics(
      state.applicationsMap.keys.toList(),
    );
  }

  Future resetStatistics() async {
    await trafficStatisticsRepository.resetStatistics();
    emit(state.copyWith(sessionStatistics: SessionStatistics()));
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

  Future startVpn({bool observeOnly = false}) async {
    if (state.running) return;
    Settings settings = settingsCubit.state.settings;

    await PermissionTools.requestNotificationPermission();
    await PermissionTools.requestBatteryOptimizationPermission();

    // clear the trafficLogRepository as it is only used for caching during a session
    await trafficLogRepository.clear();

    VpnConfig vpnConfig = await VpnTools.getConfig(settings)
      ..observeOnly = observeOnly;
    if (vpnConfig.filteredPackages.isEmpty) {
      SnackBarFactory.showNegativeSnackBar(
        "No packages are configured to be filtered. Start aborted!",
      );
      return;
    }
    await vpnController.startVpn(vpnConfig);
    emit(
      state.copyWith(
        sessionConfig: vpnConfig,
        sessionStatistics: await _attachToSession(),
        running: true,
      ),
    );
  }

  Future<LiveSessionStatistics> _attachToSession({VpnConfig? session})async {
    trafficLogListener = vpnEventHandler.trafficLog.listen(_onTrafficLog);
    _notificationService.run();
    state.sessionAnalysis.clear();
    var statistics = LiveSessionStatistics.empty();
    if(session != null){
      // load logs for existing session
      List<TrafficLog> logs = await trafficLogRepository.getForSession(session.session);
      for(var log in logs) {
        state.sessionAnalysis.insert(log, state.applicationsMap);
        statistics.addLog(log);
      }
    }
    return statistics;
  }

  Future stopVpn() async {
    if (!state.running) return;
    await vpnController.stopVpn();

    _notificationService.stop();
    await trafficLogListener?.cancel();
    trafficLogListener = null;

    emit(state.copyWith(running: false, sessionStatistics: await loadGlobalStatistics()));
  }

  void setVpnState(bool running) => emit(state.copyWith(running: running));

  void _onTrafficLog(TrafficLog event) {
    if(state.sessionStatistics is LiveSessionStatistics){
      LiveSessionStatisticsExtension(state.sessionStatistics as LiveSessionStatistics).addLog(event);
    }else{
      state.sessionStatistics.addLog(event);
    }
    state.sessionAnalysis.insert(event, state.applicationsMap);
    trafficLogRepository.insert(event);
    trafficStatisticsRepository.addLog(event);
  }
}

@freezed
class SessionState with _$SessionState {
  const SessionState({
    this.sessionConfig,
    this.running = false,
    required this.sessionAnalysis,
    this.systemApplicationsMap = const {},
    this.thirdPartyApplicationsMap = const {},
    required this.sessionStatistics,
  });

  @override
  final VpnConfig? sessionConfig;
  @override
  final bool running;
  @override
  final SessionLogAnalysisCubit sessionAnalysis;
  @override
  final Map<String, Application> systemApplicationsMap;
  @override
  final Map<String, Application> thirdPartyApplicationsMap;

  @override
  final SessionStatistics sessionStatistics;

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
