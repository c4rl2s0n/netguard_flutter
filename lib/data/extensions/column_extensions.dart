import 'package:drift/drift.dart';
import 'package:netguard/common/logic/tools/id_tools.dart';

mixin IdExtension on Table {
  TextColumn get id => text().clientDefault(() => IdTools.generateUuid())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
