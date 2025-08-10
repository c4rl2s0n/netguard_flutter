import 'package:netguard/data/data.dart';
import 'repository_base.dart';

abstract class ITrafficStatisticsRepository extends RepositoryBase {
  ITrafficStatisticsRepository(super.db);

  Future<List<TrafficStatistics>> getAll();
  Future<SessionStatistics> getPackageStatistics(
      List<String> availablePackages,
      );

  Future<TrafficStatistics?> get(String? packageName, String endpoint, EndpointType type);
  Future<Set<String>> getHostsForPackage(String? packageName);
  Future<Set<String>> getIPsForPackage(String? packageName);
  Future insert(TrafficStatistics entity);
  Future addLog(TrafficLog log);
  Future updateCount(
    String? packageName,
    String endpoint,
    EndpointType type,
    int addCountAllowed,
    int addSizeAllowed,
    int addCountBlocked,
    int addSizeBlocked,
  );
  Future resetStatistics();
}
