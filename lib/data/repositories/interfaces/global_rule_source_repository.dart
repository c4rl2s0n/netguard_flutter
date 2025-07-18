import 'package:netguard/data/data.dart';
import 'repository_base.dart';

abstract class IGlobalRuleSourceRepository extends RepositoryBase {
  Future<List<GlobalRuleSource>> getOnline();
  Future<List<GlobalRuleSource>> getLocal();
  Future<List<GlobalRuleSource>> getAll();
  Future update(GlobalRuleSource entity);
  Future updateAll(List<GlobalRuleSource> entities);
}
