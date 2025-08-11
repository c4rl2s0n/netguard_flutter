import 'package:netguard/netguard.dart';
import 'package:drift/drift.dart';

class TrafficLogRepository extends ITrafficLogRepository {
  TrafficLogRepository(super.db);

  @override
  Future<List<TrafficLog>> getAll() {
    return (db.trafficLogTable.select()..orderBy([
          (t) => OrderingTerm(expression: t.time, mode: OrderingMode.desc),
        ]))
        .get();
  }

  @override
  Future<List<TrafficLog>> getForSession(String session) {
    return (db.trafficLogTable.select()
          ..where((t) => t.session.equals(session))
          ..orderBy([
            (t) => OrderingTerm(expression: t.time, mode: OrderingMode.desc),
          ]))
        .get();
  }

  @override
  Future insert(TrafficLog entity) async {
    await db.trafficLogTable.insertOnConflictUpdate(entity.companion);
  }

  @override
  Future clear() async {
    await db.trafficLogTable.deleteAll();
  }
}
