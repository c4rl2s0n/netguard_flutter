import 'package:netguard/data/repositories/interfaces/repository_base.dart';
import 'package:netguard/data/data.dart';

abstract class IApplicationSettingsRepository extends RepositoryBase {
  IApplicationSettingsRepository(super.db);

  Future<List<ApplicationSetting>> getAll();
  Future<List<ApplicationSetting>> getActive();
  Future<List<ApplicationSetting>> getIgnored();
  Future<ApplicationSetting?> getForPackage(String packageName);
  Future<void> insert(ApplicationSetting entry);
}
