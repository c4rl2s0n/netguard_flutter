import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:netguard/data/data.dart';

import 'repository_base.dart';

abstract class ISettingsRepository extends RepositoryBase {
  ISettingsRepository(super.db);

  Future<Settings> get();
  Future<void> update(Settings settings);

  Future<void> updateDarkMode(bool darkMode);
  Future<void> updateColorScheme(FlexScheme colorScheme);
  Future<void> updateIncludeSystemApps(bool includeSystemApps);
  Future<void> updateLogTraffic(bool logTraffic);
  Future<void> updateLogCompactView(bool logCompactView);
  Future<void> updateLastHostlistUpdate(DateTime? lastUpdate);
  Future<void> updateAnalysisSettingsVolumeType(VolumeType volumeType);
  Future<void> updateChartSettingsSorting(LogSorting logSorting);
  Future<void> updateChartSettingsChartType(ChartType chartType);
  Future<void> updateChartSettingsGroupType(GroupType groupType);
  Future<void> updateChartSettingsSingleBar(bool singleBar);
}
