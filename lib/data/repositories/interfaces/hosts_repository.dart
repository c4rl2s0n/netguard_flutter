import 'package:netguard/data/data.dart';
import 'package:netguard/data/repositories/interfaces/repository_base.dart';

abstract class IHostsRepository extends RepositoryBase {
  IHostsRepository(super.db);
  Future<int> getGenericCount();
  Future<List<HostEntry>> getAll();
  Future<List<HostEntry>> getGeneric();
  Future<int> clearGeneric();
  Future<List<HostEntry>> getForRule(String ruleId);
  Future<List<HostEntry>> getForPackage(String packageName);
  Future<void> insert(HostEntry entry);
  Future<void> insertAll(List<HostEntry> entries);
}
