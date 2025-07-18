import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

@UseRowClass(ResourceRecord)
@TableIndex(
  name: "indexDns",
  columns: {#qName, #aName, #resource},
  unique: true,
)
@TableIndex(name: "indexDnsResource", columns: {#resource})
class ResourceRecordTable extends Table with IdExtension {
  IntColumn get time => integer()();
  TextColumn get qName => text()();
  TextColumn get aName => text()();
  TextColumn get resource => text()();
  IntColumn get ttl => integer().nullable()();
  IntColumn get uid => integer().nullable()();
}
