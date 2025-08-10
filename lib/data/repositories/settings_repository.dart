import 'package:drift/drift.dart';
import 'package:flex_color_scheme/src/flex_scheme.dart';
import 'package:netguard/data/data.dart';

class SettingsRepository extends ISettingsRepository {
  SettingsRepository(super.db);

  @override
  Future<Settings> get() async {
    Settings? settings =
        (await (db.settingsTable.select()..limit(1)).get()).firstOrNull;
    if (settings == null) {
      settings = Settings();
      await update(settings);
      return settings;
    }
    return settings;
  }

  @override
  Future<void> update(Settings settings) async {
    await db.settingsTable.insertOnConflictUpdate(settings.companion);
  }

  UpdateStatement<$SettingsTableTable, Settings> _updateSetting() =>
      db.settingsTable.update()..where((t) => t.id.equals(0));

  @override
  Future<void> updateAnalysisSettingsVolumeType(VolumeType volumeType) async {
    await _updateSetting().write(
      SettingsTableCompanion(analysisSettingsVolumeType: Value(volumeType)),
    );
  }

  @override
  Future<void> updateChartSettingsChartType(ChartType chartType) async {
    await _updateSetting().write(
      SettingsTableCompanion(chartSettingsChartType: Value(chartType)),
    );
  }

  @override
  Future<void> updateChartSettingsGroupType(GroupType groupType) async {
    await _updateSetting().write(
      SettingsTableCompanion(chartSettingsGroupType: Value(groupType)),
    );
  }

  @override
  Future<void> updateChartSettingsSingleBar(bool singleBar) async {
    await _updateSetting().write(
      SettingsTableCompanion(chartSettingsSingleBar: Value(singleBar)),
    );
  }

  @override
  Future<void> updateChartSettingsSorting(LogSorting logSorting) async {
    await _updateSetting().write(
      SettingsTableCompanion(chartSettingsSorting: Value(logSorting)),
    );
  }

  @override
  Future<void> updateColorScheme(FlexScheme colorScheme) async {
    await _updateSetting().write(
      SettingsTableCompanion(colorScheme: Value(colorScheme)),
    );
  }

  @override
  Future<void> updateDarkMode(bool darkMode) async {
    await _updateSetting().write(
      SettingsTableCompanion(darkMode: Value(darkMode)),
    );
  }

  @override
  Future<void> updateIncludeSystemApps(bool includeSystemApps) async {
    await _updateSetting().write(
      SettingsTableCompanion(includeSystemApps: Value(includeSystemApps)),
    );
  }

  @override
  Future<void> updateLastHostlistUpdate(DateTime? lastUpdate) async {
    await _updateSetting().write(
      SettingsTableCompanion(lastHostlistUpdate: Value(lastUpdate)),
    );
  }

  @override
  Future<void> updateLogCompactView(bool logCompactView) async {
    await _updateSetting().write(
      SettingsTableCompanion(logCompactView: Value(logCompactView)),
    );
  }

  @override
  Future<void> updateLogTraffic(bool logTraffic) async {
    await _updateSetting().write(
      SettingsTableCompanion(logTraffic: Value(logTraffic)),
    );
  }
}
