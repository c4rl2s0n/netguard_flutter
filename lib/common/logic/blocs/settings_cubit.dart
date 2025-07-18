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
  void toggleIncludeSystemApps() {
    emit(state.copyWith(includeSystemApps: !state.includeSystemApps));
    saveSettings();
  }

  void setLastBlacklistUpdate() {
    emit(state.copyWith(lastBlacklistUpdate: DateTime.now()));
  }
}

@freezed
class SettingsState with _$SettingsState {
  const SettingsState({
    required this.darkMode,
    required this.colorScheme,
    required this.includeSystemApps,
    this.lastBlacklistUpdate,
  });

  @override
  final bool darkMode;
  @override
  final FlexScheme colorScheme;

  final bool includeSystemApps;

  final DateTime? lastBlacklistUpdate;

  SettingsState.empty() : this.fromSettings(Settings());
  SettingsState.fromSettings(Settings settings)
    : this(
        darkMode: settings.darkMode,
        colorScheme: settings.colorScheme,
        includeSystemApps: settings.includeSystemApps,
        lastBlacklistUpdate: settings.lastBlacklistScan,
      );

  Settings get settings => Settings(
    darkMode: darkMode,
    colorScheme: colorScheme,
    includeSystemApps: includeSystemApps,
    lastBlacklistScan: lastBlacklistUpdate,
  );

}
