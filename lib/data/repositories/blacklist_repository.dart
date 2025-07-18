import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

class BlacklistRepository extends IBlacklistRepository {
  @override
  Future<List<BlacklistEntry>> getAll() async {
    return await (db.blacklistTable.select()).get();
  }

  @override
  Future<List<BlacklistEntry>> getGeneric() async {
    return await (db.blacklistTable.select()
          ..where((e) => e.ruleId.equalsNullable(null)))
        .get();
  }

  @override
  Future<List<BlacklistEntry>> getForRule(String ruleId) async {
    return await (db.blacklistTable.select()
          ..where((e) => e.ruleId.equalsNullable(ruleId)))
        .get();
  }

  @override
  Future<List<BlacklistEntry>> getForPackage(String packageName) async {
    return await (db.blacklistTable.select()..join([
          innerJoin(
            db.rulesTable,
            Expression.and([
              db.blacklistTable.ruleId.equalsExp(db.rulesTable.id),
              db.rulesTable.packageName.equalsNullable(packageName),
            ]),
          ),
        ]))
        .get();
  }

  @override
  Future<void> insert(BlacklistEntry entry) async {
    await db.blacklistTable.insertOnConflictUpdate(entry.companion);
  }
  @override
  Future<void> insertAll(List<BlacklistTableCompanion> entries) async {
    await db.batch((batch) => batch.insertAllOnConflictUpdate(db.blacklistTable, entries));
  }

  @override
  Future<void> clearGeneric() async {
    await (db.blacklistTable.delete()
          ..where((e) => e.ruleId.equalsNullable(null)))
        .go();
  }
}
