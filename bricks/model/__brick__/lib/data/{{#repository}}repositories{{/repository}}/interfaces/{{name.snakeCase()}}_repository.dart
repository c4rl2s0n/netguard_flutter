import 'package:netguard/data/data.dart';
import 'repository_base.dart';

abstract class I{{name.pascalCase()}}Repository extends RepositoryBase{
  I{{name.pascalCase()}}Repository(super.db);

  Future<List<{{name.pascalCase()}}>> getAll();
  Future insert({{name.pascalCase()}} entity);
}