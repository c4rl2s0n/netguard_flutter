import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'enums.dart';

class Settings {
  Settings({
    this.id = 0,
    this.darkMode = true,
    this.colorScheme = FlexScheme.green,
    this.includeSystemApps = true,
    this.logTraffic = true,
    this.observeOnly = false,
    this.logCompactView = false,
    this.lastHostlistUpdate,
    this.analysisSettingsVolumeType = VolumeType.count,
    this.chartSettingsSorting = LogSorting.time,
    this.chartSettingsChartType = ChartType.pie,
    this.chartSettingsGroupType = GroupType.application,
    this.chartSettingsSingleBar = false,
  });
  int id;
  bool darkMode;
  FlexScheme colorScheme;
  bool includeSystemApps;
  bool logTraffic;
  bool observeOnly;
  bool logCompactView;
  DateTime? lastHostlistUpdate;
  VolumeType analysisSettingsVolumeType;
  LogSorting chartSettingsSorting;
  ChartType chartSettingsChartType;
  GroupType chartSettingsGroupType;
  bool chartSettingsSingleBar;
}
