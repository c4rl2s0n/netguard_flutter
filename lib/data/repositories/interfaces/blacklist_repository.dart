import 'package:netguard/data/data.dart';
import 'package:netguard/data/repositories/interfaces/repository_base.dart';

abstract class IBlacklistRepository extends RepositoryBase {
  Future<List<BlacklistEntry>> getAll();
  Future<List<BlacklistEntry>> getGeneric();
  Future<void> clearGeneric();
  Future<List<BlacklistEntry>> getForRule(String ruleId);
  Future<List<BlacklistEntry>> getForPackage(String packageName);
  Future<void> insert(BlacklistEntry entry);
  Future<void> insertAll(List<BlacklistTableCompanion> entries);
}
