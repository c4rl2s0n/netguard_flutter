import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

part 'session_cubit.freezed.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit()
    : super(SessionState(sessionLogState: SessionLogsState.empty()));

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
    Settings settings = settingsCubit.state.settings;

    await PermissionTools.requestNotificationPermission();
    await PermissionTools.requestBatteryOptimizationPermission();

    VpnConfig vpnConfig = await VpnTools.getConfig(settings);
    await vpnController.startVpn(vpnConfig);
    trafficLogListener = vpnEventHandler.trafficLog.listen(_onTrafficLog);
    emit(
      state.copyWith(
        sessionId: vpnConfig.session,
        sessionLogState: state.sessionLogState.clear(),
      ),
    );
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
      state.copyWith(sessionLogState: state.sessionLogState.addEvent(event)),
    );
  }
}

@freezed
class SessionState with _$SessionState {
  const SessionState({
    this.sessionId,
    required this.sessionLogState,
    this.systemApplicationsMap = const {},
    this.thirdPartyApplicationsMap = const {},
  });

  @override
  final String? sessionId;
  @override
  final SessionLogsState sessionLogState;
  @override
  final Map<String, Application> systemApplicationsMap;
  @override
  final Map<String, Application> thirdPartyApplicationsMap;

  bool get running => sessionId.notEmpty;
  bool get hasLogs => sessionLogState.hasLogs;

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

@freezed
class SessionLogsState with _$SessionLogsState {
  const SessionLogsState._({
    this.sessionTrafficLog = const IListConst([]),
    this.sessionTrafficLogByApp = const IMapConst({}),
    required this.sessionTrafficLogGroups,
  });
  factory SessionLogsState.empty() =>
      SessionLogsState._(sessionTrafficLogGroups: TrafficLogGroups());

  @override
  final IList<TrafficLog> sessionTrafficLog;
  @override
  final IMap<String?, IList<TrafficLog>> sessionTrafficLogByApp;
  @override
  final TrafficLogGroups sessionTrafficLogGroups;

  bool get hasLogs => sessionTrafficLog.notEmpty;

  SessionLogsState clear() {
    return SessionLogsState.empty();
  }

  SessionLogsState addEvent(TrafficLog event) {
    IMap<String?, IList<TrafficLog>> logByApp = sessionTrafficLogByApp;
    IList<TrafficLog> appLog =
        logByApp.get(event.packageName) ?? IList<TrafficLog>();

    sessionTrafficLogGroups.insert(event);
    return copyWith(
      sessionTrafficLog: sessionTrafficLog.add(event),
      sessionTrafficLogByApp: logByApp.add(
        event.packageName,
        appLog.add(event),
      ),
    );
  }
}
