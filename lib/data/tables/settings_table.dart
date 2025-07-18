import 'package:drift/drift.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:netguard/data/data.dart';

@UseRowClass(Settings)
class SettingsTable extends Table {
  IntColumn get id => integer().clientDefault(() => 0)();
  BoolColumn get darkMode => boolean()();
  TextColumn get colorScheme => textEnum<FlexScheme>()();
  BoolColumn get includeSystemApps => boolean()();
  DateTimeColumn get lastBlacklistScan => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
