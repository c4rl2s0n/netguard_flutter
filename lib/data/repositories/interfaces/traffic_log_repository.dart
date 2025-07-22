import 'package:netguard/data/data.dart';
import 'repository_base.dart';

abstract class ITrafficLogRepository extends RepositoryBase {
  ITrafficLogRepository(super.db);

  Future<List<TrafficLog>> getAll();
  Future<List<TrafficLog>> getForSession(String session);
  Future<List<TrafficLog>> getForPackage(String? packageName);
  Future<Set<String>> getHostsForPackage(String? packageName);
  Future<Set<String>> getIPsForPackage(String? packageName);
  Future insert(TrafficLog entity);
}
