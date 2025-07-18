import 'package:drift/drift.dart';
import 'package:netguard/data/models/models.dart';

@UseRowClass(ApplicationSetting)
class ApplicationSettingTable extends Table {
  TextColumn get packageName => text()();
  BoolColumn get filter => boolean()();

  @override
  Set<Column<Object>>? get primaryKey => {packageName};
}
