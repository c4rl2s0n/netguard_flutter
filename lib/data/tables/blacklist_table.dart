import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

import 'rules_table.dart';

@UseRowClass(BlacklistEntry)
@TableIndex(name: "blacklistRuleIndex", columns: {#ruleId})
@TableIndex(name: "blacklistTypeIndex", columns: {#type})
class BlacklistTable extends Table with IdExtension {
  TextColumn get ruleId => text().nullable().references(RulesTable, #id)();
  TextColumn get target => text()();
  TextColumn get type => textEnum<BlacklistType>()();
  TextColumn get source => text().nullable()();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [{ruleId, target, type}];
}
