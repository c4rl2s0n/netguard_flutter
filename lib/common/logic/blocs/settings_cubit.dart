import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/data/data.dart';

part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository) : super(SettingsState.empty()) {
    _load();
  }

  Future _load() async {
    emit(SettingsState.fromSettings(await _settingsRepository.get()));
  }

  final ISettingsRepository _settingsRepository;

  void saveSettings() {
    _settingsRepository.update(state.settings);
  }

  // THEME SETTINGS
  void toggleDarkMode() {
    emit(state.copyWith(darkMode: !state.darkMode));
    saveSettings();
  }

  void setColorScheme(FlexScheme colorScheme) {
    emit(state.copyWith(colorScheme: colorScheme));
    saveSettings();
  }


  // VPN SETTINGS
  void setIncludeSystemApps(bool includeSystem) {
    emit(state.copyWith(includeSystemApps: includeSystem));
    saveSettings();
  }
  void toggleLogTraffic() {
    emit(state.copyWith(logTraffic: !state.logTraffic));
    saveSettings();
  }
  void setObserveOnly(bool observeOnly){
    emit(state.copyWith(observeOnly: observeOnly));
    saveSettings();
  }

  // MISC

  void setLogCompactView(bool logCompact) {
    emit(state.copyWith(logCompactView: logCompact));
    saveSettings();
  }
  void setLastBlacklistUpdate() {
    emit(state.copyWith(lastHostlistUpdate: DateTime.now()));
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
      );

  Settings get settings => Settings(
    darkMode: darkMode,
    colorScheme: colorScheme,
    includeSystemApps: includeSystemApps,
    logTraffic: logTraffic,
    observeOnly: observeOnly,
    logCompactView: logCompactView,
    lastHostlistUpdate: lastHostlistUpdate,
  );

}
