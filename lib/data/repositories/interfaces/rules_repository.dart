import 'package:netguard/data/data.dart';

import 'repository_base.dart';

abstract class IRulesRepository extends RepositoryBase {
  IRulesRepository(super.db);

  Future<List<Rule>> getGlobal();
  Future<List<Rule>> getForPackage(
    String? packageName, {
    bool activeOnly = false,
  });
  Future<void> delete(String id);
  Future<void> updateName(String id, String name);
  Future<void> updateDescription(String id, String description);
  Future<void> updateType(String id, RuleType type);
  Future<void> updateActive(String id, bool active);
  Future<void> updateHosts(String id, List<HostEntry> hosts);
  Future<void> insert(Rule entry);
  Future<void> insertAll(List<Rule> entries);
}
