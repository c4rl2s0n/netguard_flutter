import 'package:netguard/netguard.dart';
import 'repository_base.dart';

abstract class IResourceRecordRepository extends RepositoryBase {
  Future<List<ResourceRecord>> getAll();
  Future update(ResourceRecord entity);
}
