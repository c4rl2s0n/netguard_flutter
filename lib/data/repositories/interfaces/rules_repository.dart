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
  Future<void> insert(Rule entry);
  Future<void> insertAll(List<Rule> entries);
}
