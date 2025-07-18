import 'package:drift/drift.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/common/service_locator/accessors.dart';
import 'package:netguard/data/data.dart';

class RulesRepository extends IRulesRepository {
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
    IBlacklistRepository repo = blacklistRepository;
    for (var rule in rules) {
      List<BlacklistEntry> blacklist = packageName.empty
          ? await repo.getGeneric()
          : await repo.getForPackage(packageName!);
      rule.blockedHosts = blacklist
          .where((b) => b.type == BlacklistType.host)
          .map((b) => b.target)
          .toList();
      rule.blockedIPs = blacklist
          .where((b) => b.type == BlacklistType.ip)
          .map((b) => b.target)
          .toList();
    }
    return rules;
  }

  @override
  Future<void> insert(Rule entry) async {
    await db.rulesTable.insertOnConflictUpdate(entry.companion);
  }
}
