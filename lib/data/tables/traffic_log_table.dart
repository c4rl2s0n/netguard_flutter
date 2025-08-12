import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

@UseRowClass(TrafficLog)
@TableIndex(name: "trafficLogSession", columns: {#session})
@TableIndex(name: "trafficLogSessionTime", columns: {#session, #time})
@TableIndex(name: "trafficLogTime", columns: {#time})
class TrafficLogTable extends Table with IdExtension {
  IntColumn get time => integer()();
  TextColumn get session => text()();
  IntColumn get protocol => integer()();
  TextColumn get ip => text()();
  TextColumn get host => text().nullable()();
  TextColumn get packageName => text().nullable()();
  IntColumn get size => integer()();
  BoolColumn get allowed => boolean()();
  BoolColumn get outgoing => boolean()();
}
