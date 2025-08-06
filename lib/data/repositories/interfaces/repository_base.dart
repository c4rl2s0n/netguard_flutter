import 'package:drift/drift.dart';
import 'package:netguard/data/data.dart';

class RepositoryBase {
  RepositoryBase(this.db);
  final AppDatabase db;

  CustomExpression<int> addInt(GeneratedColumn<int> column, int value) {
    return CustomExpression('${column.name} + $value');
  }
}
