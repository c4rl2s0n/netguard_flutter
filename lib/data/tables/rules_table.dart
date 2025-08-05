import 'package:drift/drift.dart';
import 'package:netguard/data/data.dart';

@UseRowClass(Rule)
@TableIndex(name: "package", columns: {#packageName})
class RulesTable extends Table with IdExtension {
  TextColumn get packageName => text()();
  TextColumn get name => text().nullable()();
  TextColumn get targetVersion => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get active => boolean()();
  TextColumn get type => textEnum<RuleType>()();
  BoolColumn get shouldBlockQuic => boolean()();
  BoolColumn get whitelistExclusive => boolean()();
}
