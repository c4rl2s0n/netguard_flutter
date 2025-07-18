import 'package:netguard/data/data.dart';

import 'repository_base.dart';

abstract class IRulesRepository extends RepositoryBase {
  Future<List<Rule>> getGlobal();
  Future<List<Rule>> getForPackage(
    String? packageName, {
    bool activeOnly = false,
  });
  Future<void> insert(Rule entry);
}
