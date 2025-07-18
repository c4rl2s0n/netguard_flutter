import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

@UseRowClass(GlobalRuleSource)
@TableIndex(name: "globalRuleTypeIndex", columns: {#type})
class GlobalRuleSourceTable extends Table with IdExtension {
  TextColumn get source => text()();
  TextColumn get type => textEnum<SourceType>()();
}
