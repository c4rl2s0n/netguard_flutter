import 'package:netguard/netguard.dart';
import 'package:drift/drift.dart';

class TrafficLogRepository extends ITrafficLogRepository {
  TrafficLogRepository(super.db);

  @override
  Future<List<TrafficLog>> getAll() {
    return (db.trafficLogTable.select()).get();
  }

  @override
  Future<List<TrafficLog>> getForPackage(String? packageName) {
    return (db.trafficLogTable.select()
          ..where((t) => t.packageName.equalsNullable(packageName)))
        .get();
  }

  @override
  Future<List<TrafficLog>> getForSession(String session) {
    return (db.trafficLogTable.select()
          ..where((t) => t.session.equals(session)))
        .get();
  }

  @override
  Future<Set<String>> getHostsForPackage(String? packageName) async {
    return (await (db.trafficLogTable.selectOnly(distinct: true)
              ..addColumns([
                db.trafficLogTable.host,
                db.trafficLogTable.packageName,
              ])
              ..where(
                db.trafficLogTable.packageName.equalsNullable(packageName),
              ))
            .map((row) => row.read(db.trafficLogTable.host))
            .get())
        .nonNulls
        .toSet();
  }

  @override
  Future<Set<String>> getIPsForPackage(String? packageName) async {
    return (await (db.trafficLogTable.selectOnly(distinct: true)
              ..addColumns([
                db.trafficLogTable.ip,
                db.trafficLogTable.packageName,
              ])
              ..where(
                db.trafficLogTable.packageName.equalsNullable(packageName),
              ))
            .map((row) => row.read(db.trafficLogTable.ip))
            .get())
        .nonNulls
        .toSet();
  }

  @override
  Future insert(TrafficLog entity) async {
    await db.trafficLogTable.insertOnConflictUpdate(entity.companion);
  }
}
