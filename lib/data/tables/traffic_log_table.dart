import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

@UseRowClass(TrafficLog)
@TableIndex(name: "trafficLogSessionPackage", columns: {#session, #packageName})
@TableIndex(name: "trafficLogPackageIp", columns: {#packageName, #ip})
@TableIndex(name: "trafficLogPackageHost", columns: {#packageName, #host})
@TableIndex(name: "trafficLogPackageAllowed", columns: {#packageName, #allowed})
@TableIndex(name: "trafficLogAllowed", columns: {#allowed})
@TableIndex(name: "trafficLogSessionTime", columns: {#session, #time})
class TrafficLogTable extends Table with IdExtension{
  IntColumn get time => integer()();
  TextColumn get session => text()();
  IntColumn get protocol => integer()();
  TextColumn get packageName => text().nullable()();
  TextColumn get ip => text()();
  TextColumn get host => text().nullable()();
  BoolColumn get allowed => boolean()();
}
