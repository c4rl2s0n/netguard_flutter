import 'package:netguard/data/data.dart';
import 'repository_base.dart';

abstract class ITrafficLogRepository extends RepositoryBase {
  ITrafficLogRepository(super.db);

  Future<List<TrafficLog>> getAll();
  Future<List<TrafficLog>> getForSession(String session);
  Future clear();
  Future insert(TrafficLog entity);
}
