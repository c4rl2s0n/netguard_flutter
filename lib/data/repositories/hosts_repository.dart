import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

class HostsRepository extends IHostsRepository {
  HostsRepository(super.db);

  @override
  Future<List<HostEntry>> getAll() async {
    return await (db.hostsTable.select()).get();
  }

  @override
  Future<List<HostEntry>> getGeneric() async {
    return await (db.hostsTable.select()
          ..where((e) => e.ruleId.equalsNullable(null)))
        .get();
  }

  @override
  Future<List<HostEntry>> getForRule(String ruleId) async {
    return await (db.hostsTable.select()
          ..where((e) => e.ruleId.equalsNullable(ruleId)))
        .get();
  }

  @override
  Future<List<HostEntry>> getForPackage(String packageName) async {
    return await (db.hostsTable.select()..join([
          innerJoin(
            db.rulesTable,
            Expression.and([
              db.hostsTable.ruleId.equalsExp(db.rulesTable.id),
              db.rulesTable.packageName.equalsNullable(packageName),
            ]),
          ),
        ]))
        .get();
  }

  @override
  Future<void> insert(HostEntry entry) async {
    await db.hostsTable.insertOnConflictUpdate(entry.companion);
  }

  @override
  Future<void> insertAll(List<HostEntry> entries) async {
    var companions = entries.map((e) => e.companion);
    await db.batch(
      (batch) => batch.insertAllOnConflictUpdate(db.hostsTable, companions),
    );
  }

  @override
  Future<int> clearGeneric() async {
    return await (db.hostsTable.delete()..where((e) => e.ruleId.equalsNullable(null)))
        .go();
  }

  @override
  Future<int> getGenericCount() async {
    Expression<int> genericCount = db.hostsTable.target.count();
    return await (db.selectOnly(db.hostsTable)
          ..addColumns([genericCount])
          ..where(db.hostsTable.ruleId.equalsNullable(null)))
        .map((row) => row.read(genericCount)!)
        .getSingle();
  }
}
