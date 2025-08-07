import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

@UseRowClass(PackageStatistics)
class PackageStatisticsTable extends Table {
  TextColumn get packageName => text()();
  IntColumn get packetCountAllowed => integer().clientDefault(() => 0)();
  IntColumn get packetSizeAllowed => integer().clientDefault(() => 0)();
  IntColumn get packetCountBlocked => integer().clientDefault(() => 0)();
  IntColumn get packetSizeBlocked => integer().clientDefault(() => 0)();

  @override
  Set<Column<Object>> get primaryKey => {packageName};
}
