import 'package:drift/drift.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:netguard/data/data.dart';

@UseRowClass(Settings)
class SettingsTable extends Table {
  IntColumn get id => integer().clientDefault(() => 0)();
  BoolColumn get darkMode => boolean()();
  TextColumn get colorScheme => textEnum<FlexScheme>()();
  BoolColumn get includeSystemApps => boolean()();
  BoolColumn get logTraffic => boolean()();
  BoolColumn get logCompactView => boolean()();
  DateTimeColumn get lastHostlistUpdate => dateTime().nullable()();
  TextColumn get analysisSettingsVolumeType => textEnum<VolumeType>()();
  TextColumn get chartSettingsSorting => textEnum<LogSorting>()();
  TextColumn get chartSettingsChartType => textEnum<ChartType>()();
  TextColumn get chartSettingsGroupType => textEnum<GroupType>()();
  BoolColumn get chartSettingsSingleBar => boolean()();
  IntColumn get overallPacketCount => integer().clientDefault(() => 0)();
  IntColumn get overallPacketSize => integer().clientDefault(() => 0)();
  IntColumn get overallPacketBlockedCount => integer().clientDefault(() => 0)();
  IntColumn get overallPacketBlockedSize => integer().clientDefault(() => 0)();
  TextColumn get packageNameMostTraffic => text().nullable()();
  TextColumn get packageNameMostTrafficBlocked => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
