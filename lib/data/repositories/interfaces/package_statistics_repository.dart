import 'package:netguard/data/data.dart';
import 'repository_base.dart';

abstract class IPackageStatisticsRepository extends RepositoryBase {
  IPackageStatisticsRepository(super.db);

  Future<List<PackageStatistics>> getAll();
  Future<PackageStatistics?> get(String packageName);
  Future<SessionStatistics> getOverallStatistics(List<String> availablePackages);
  Future insert(PackageStatistics entity);
  Future addLog(TrafficLog log);
  Future updateCount(
    String packageName,
    int addCountAllowed,
    int addSizeAllowed,
    int addCountBlocked,
    int addSizeBlocked,
  );
  Future resetStatistics();
}
