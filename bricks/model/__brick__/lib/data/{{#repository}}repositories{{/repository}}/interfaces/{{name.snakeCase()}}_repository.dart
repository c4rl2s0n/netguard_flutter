import 'package:netguard/data/data.dart';
import 'repository_base.dart';

abstract class I{{name.pascalCase()}}Repository extends RepositoryBase{
  Future<List<{{name.pascalCase()}}>> getAll();
  Future update({{name.pascalCase()}} entity);
}