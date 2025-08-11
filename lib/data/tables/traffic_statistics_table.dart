import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

@UseRowClass(TrafficStatistics)
class TrafficStatisticsTable extends Table {
  TextColumn get packageName => text().nullable()();
  TextColumn get endpoint => text()();
  TextColumn get endpointType => textEnum<EndpointType>()();
  IntColumn get packetCountAllowed => integer().clientDefault(() => 0)();
  IntColumn get packetSizeAllowed => integer().clientDefault(() => 0)();
  IntColumn get packetCountBlocked => integer().clientDefault(() => 0)();
  IntColumn get packetSizeBlocked => integer().clientDefault(() => 0)();
  IntColumn get latest => integer().clientDefault(() => 0)();

  @override
  Set<Column<Object>> get primaryKey => {packageName, endpoint};
}
