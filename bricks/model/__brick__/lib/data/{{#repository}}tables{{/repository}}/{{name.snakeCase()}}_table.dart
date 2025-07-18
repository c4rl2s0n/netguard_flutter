import 'package:drift/drift.dart';
import 'package:netguard/netguard.dart';

@UseRowClass({{name.pascalCase()}})
class {{name.pascalCase()}}Table extends Table {{#withId}}with IdExtension{{/withId}}{
  TextColumn get textTest => text().nullable()();
  BoolColumn get boolTest => boolean()();
  TextColumn get enumTest => textEnum<BlacklistType>()();
  IntColumn get intTest => integer().nullable()();
}
