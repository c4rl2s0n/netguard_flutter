import 'package:netguard/common/native/native_bridge.g.dart';
import 'package:netguard/data/repositories/interfaces/repository_base.dart';

abstract class IApplicationSettingsRepository extends RepositoryBase {
  Future<List<ApplicationSetting>> getAll();
  Future<List<ApplicationSetting>> getActive();
  Future<List<ApplicationSetting>> getIgnored();
  Future<ApplicationSetting?> getForPackage(String packageName);
  Future<void> insert(ApplicationSetting entry);
}
