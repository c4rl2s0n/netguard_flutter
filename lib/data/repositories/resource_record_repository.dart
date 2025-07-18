import 'package:netguard/netguard.dart';
import 'package:drift/drift.dart';

class ResourceRecordRepository extends IResourceRecordRepository {
  @override
  Future<List<ResourceRecord>> getAll() async {
    return await db.resourceRecordTable.select().get();
  }

  @override
  Future update(ResourceRecord entity) async {
    await db.resourceRecordTable.insertOnConflictUpdate(entity.companion);
  }
}
