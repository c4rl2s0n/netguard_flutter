import 'package:netguard/netguard.dart';
import 'package:drift/drift.dart';

class GlobalRuleSourceRepository extends IGlobalRuleSourceRepository {
  Future<List<GlobalRuleSource>> _getForType(SourceType type) async {
    return await (db.globalRuleSourceTable.select()
          ..where((r) => r.type.equals(type.name)))
        .get();
  }

  @override
  Future update(GlobalRuleSource entity) async {
    await db.globalRuleSourceTable.insertOnConflictUpdate(entity.companion);
  }
  @override
  Future updateAll(List<GlobalRuleSource> entities) async {
    await db.globalRuleSourceTable.deleteAll();
    await db.batch((batch) => batch.insertAllOnConflictUpdate(db.globalRuleSourceTable, entities.map((e) => e.companion)));
  }

  @override
  Future<List<GlobalRuleSource>> getAll() async =>
      await (db.globalRuleSourceTable.select()).get();

  @override
  Future<List<GlobalRuleSource>> getLocal() => _getForType(SourceType.local);

  @override
  Future<List<GlobalRuleSource>> getOnline() => _getForType(SourceType.online);
}
