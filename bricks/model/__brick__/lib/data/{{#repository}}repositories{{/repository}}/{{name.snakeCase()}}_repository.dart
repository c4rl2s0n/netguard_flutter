import 'package:netguard/netguard.dart';
import 'package:drift/drift.dart';

class {{name.pascalCase()}}Repository extends I{{name.pascalCase()}}Repository{
  {{name.pascalCase()}}Repository(super.db);

  @override
  Future<List<{{name.pascalCase()}}>> getAll() async {
    return await (db.{{name.camelCase()}}Table.select()).get();
  }
  @override
  Future insert({{name.pascalCase()}} entity) async {
    await db.{{name.camelCase()}}Table.insertOnConflictUpdate(entity.companion);
  }
}