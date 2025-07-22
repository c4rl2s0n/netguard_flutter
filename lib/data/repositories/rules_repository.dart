import 'package:drift/drift.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/common/service_locator/accessors.dart';
import 'package:netguard/data/data.dart';

class RulesRepository extends IRulesRepository {
  RulesRepository(super.db);

  @override
  Future<List<Rule>> getGlobal() async {
    return await getForPackage(null);
  }

  @override
  Future<List<Rule>> getForPackage(
    String? packageName, {
    bool activeOnly = false,
  }) async {
    List<Rule> rules =
        await (db.rulesTable.select()..where(
              (e) => Expression.and([
                e.packageName.equalsNullable(packageName),
                if (activeOnly) e.active,
              ]),
            ))
            .get();

    // get the blacklists for every rule
    IHostsRepository repo = hostsRepository;
    for (var rule in rules) {
      rule.hosts = {};
      rule.ips = {};
      List<HostEntry> hosts = packageName.empty
          ? await repo.getGeneric()
          : await repo.getForPackage(packageName!);
      rule.hosts.addEntries(
        hosts
            .where((b) => b.type == HostType.host)
            .map((b) => MapEntry(b.target, true)),
      );
      rule.ips.addEntries(
        hosts
            .where((b) => b.type == HostType.ip)
            .map((b) => MapEntry(b.target, true)),
      );
    }
    return rules;
  }

  @override
  Future<void> insert(Rule entry) async {
    await db.rulesTable.insertOnConflictUpdate(entry.companion);
  }

  @override
  Future<void> insertAll(List<Rule> entries) async {
    var companions = entries.map((e) => e.companion);
    List<HostsTableCompanion> hostCompanions = [];
    for (var rule in entries) {
      // clear the host-list for the rule, in case an update takes place. The rules will be inserted afterwards
      await db.hostsTable.deleteWhere((t) => t.ruleId.equals(rule.id));
      hostCompanions.addAll(
        rule.hosts.keys.map(
          (host) => HostEntry(
            ruleId: rule.id,
            target: host,
            type: HostType.host,
          ).companion,
        ),
      );
      hostCompanions.addAll(
        rule.ips.keys.map(
          (ip) => HostEntry(
            ruleId: rule.id,
            target: ip,
            type: HostType.ip,
          ).companion,
        ),
      );
    }
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(db.rulesTable, companions);
      batch.insertAll(db.hostsTable, hostCompanions);
    });
  }

  @override
  Future<void> delete(String id) async {
    await db.hostsTable.deleteWhere((t) => t.ruleId.equals(id));
    await db.rulesTable.deleteWhere((t) => t.id.equals(id));
  }
}
