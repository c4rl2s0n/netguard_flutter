import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

import 'rules_table.dart';

@UseRowClass(HostEntry)
@TableIndex(name: "hostRuleIndex", columns: {#ruleId})
@TableIndex(name: "hostTypeIndex", columns: {#type})
//@TableIndex(name: "hostLookupIndex", columns: {#ruleId, #type, #target})
class HostsTable extends Table {
  TextColumn get ruleId => text().nullable().references(RulesTable, #id)();
  TextColumn get target => text()();
  TextColumn get type => textEnum<HostType>()();
  TextColumn get source => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {ruleId, type, target};
}
