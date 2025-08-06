import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/data/data.dart';

part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository) : super(SettingsState.empty()) {
    _load();
  }

  final Completer<bool> _initialized = Completer();
  Future _load() async {
    emit(SettingsState.fromSettings(await _settingsRepository.get()));
    _initialized.complete(true);
  }
  Future ensureLoaded() async {
    return _initialized.isCompleted || await _initialized.future;
  }

  final ISettingsRepository _settingsRepository;

  void saveSettings() {
    _settingsRepository.update(state.settings);
  }

  // THEME SETTINGS
  void toggleDarkMode() {
    emit(state.copyWith(darkMode: !state.darkMode));
    _settingsRepository.updateDarkMode(state.darkMode);
  }

  void setColorScheme(FlexScheme colorScheme) {
    emit(state.copyWith(colorScheme: colorScheme));
    _settingsRepository.updateColorScheme(colorScheme);
  }

  // VPN SETTINGS
  void setIncludeSystemApps(bool includeSystem) {
    emit(state.copyWith(includeSystemApps: includeSystem));
    _settingsRepository.updateIncludeSystemApps(includeSystem);
  }

  void toggleLogTraffic() {
    emit(state.copyWith(logTraffic: !state.logTraffic));
    _settingsRepository.updateLogTraffic(state.logTraffic);
  }

  void setObserveOnly(bool observeOnly) {
    emit(state.copyWith(observeOnly: observeOnly));
    _settingsRepository.updateObserveOnly(observeOnly);
  }

  // ANALYSIS
  void setAnalysisVolumeType(VolumeType analysisVolumeType) {
    emit(state.copyWith(analysisVolumeType: analysisVolumeType));
    _settingsRepository.updateAnalysisSettingsVolumeType(analysisVolumeType);
  }

  void setAnalysisChartGroupType(GroupType analysisChartGroupType) {
    emit(state.copyWith(analysisChartGroupType: analysisChartGroupType));
    _settingsRepository.updateChartSettingsGroupType(analysisChartGroupType);
  }

  void setAnalysisChartType(ChartType analysisChartType) {
    emit(state.copyWith(analysisChartType: analysisChartType));
    _settingsRepository.updateChartSettingsChartType(analysisChartType);
  }

  void setAnalysisChartSorting(LogSorting analysisChartSorting) {
    emit(state.copyWith(analysisChartSorting: analysisChartSorting));
    _settingsRepository.updateChartSettingsSorting(analysisChartSorting);
  }

  void setAnalysisChartSingleBar(bool analysisChartSingleBar) {
    emit(state.copyWith(analysisChartSingleBar: analysisChartSingleBar));
    _settingsRepository.updateChartSettingsSingleBar(analysisChartSingleBar);
  }

  // MISC

  void setLogCompactView(bool logCompact) {
    emit(state.copyWith(logCompactView: logCompact));
    _settingsRepository.updateLogCompactView(logCompact);
  }

  void setLastHostlistUpdate() {
    emit(state.copyWith(lastHostlistUpdate: DateTime.now()));
    _settingsRepository.updateLastHostlistUpdate(state.lastHostlistUpdate);
  }
}

@freezed
class SettingsState with _$SettingsState {
  const SettingsState({
    required this.darkMode,
    required this.colorScheme,
    required this.includeSystemApps,
    required this.logTraffic,
    required this.observeOnly,
    required this.logCompactView,
    this.lastHostlistUpdate,
    required this.analysisVolumeType,
    required this.analysisChartGroupType,
    required this.analysisChartType,
    required this.analysisChartSorting,
    required this.analysisChartSingleBar,
  });

  @override
  final bool darkMode;
  @override
  final FlexScheme colorScheme;

  @override
  final bool includeSystemApps;
  @override
  final bool logTraffic;
  @override
  final bool observeOnly;

  @override
  final bool logCompactView;

  @override
  final DateTime? lastHostlistUpdate;

  final VolumeType analysisVolumeType;
  final GroupType analysisChartGroupType;
  final ChartType analysisChartType;
  final LogSorting analysisChartSorting;
  final bool analysisChartSingleBar;

  SettingsState.empty() : this.fromSettings(Settings());
  SettingsState.fromSettings(Settings settings)
    : this(
        darkMode: settings.darkMode,
        colorScheme: settings.colorScheme,
        includeSystemApps: settings.includeSystemApps,
        logTraffic: settings.logTraffic,
        observeOnly: settings.observeOnly,
        logCompactView: settings.logCompactView,
        lastHostlistUpdate: settings.lastHostlistUpdate,
        analysisVolumeType: settings.analysisSettingsVolumeType,
        analysisChartGroupType: settings.chartSettingsGroupType,
        analysisChartType: settings.chartSettingsChartType,
        analysisChartSorting: settings.chartSettingsSorting,
        analysisChartSingleBar: settings.chartSettingsSingleBar,
      );

  Settings get settings => Settings(
    darkMode: darkMode,
    colorScheme: colorScheme,
    includeSystemApps: includeSystemApps,
    logTraffic: logTraffic,
    observeOnly: observeOnly,
    logCompactView: logCompactView,
    lastHostlistUpdate: lastHostlistUpdate,
    analysisSettingsVolumeType: analysisVolumeType,
    chartSettingsGroupType: analysisChartGroupType,
    chartSettingsChartType: analysisChartType,
    chartSettingsSorting: analysisChartSorting,
    chartSettingsSingleBar: analysisChartSingleBar,
  );
}
