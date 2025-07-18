import 'package:drift/drift.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

class ApplicationSettingsRepository extends IApplicationSettingsRepository {
  List<ApplicationSetting> _getInstalled(List<ApplicationSetting> all) {
    List<Application> installedApplications = sessionCubit.state.applications;
    return all
        .where(
          (i) =>
              installedApplications.any((a) => i.packageName == a.packageName),
        )
        .toList();
  }

  @override
  Future<ApplicationSetting?> getForPackage(String packageName) async {
    var all =
        await (db.applicationSettingTable.select()
              ..where((a) => a.packageName.equals(packageName)))
            .get();
    return all.firstOrNull;
  }

  @override
  Future<List<ApplicationSetting>> getAll() async {
    // TODO: better to just return all, or filter by packageNames?
    var all = await (db.applicationSettingTable.select()).get();
    return _getInstalled(all);
  }

  @override
  Future<List<ApplicationSetting>> getActive() async {
    var active =
        await (db.applicationSettingTable.select()..where((a) => a.filter))
            .get();
    return _getInstalled(active);
  }

  @override
  Future<List<ApplicationSetting>> getIgnored() async {
    var ignored =
        await (db.applicationSettingTable.select()
              ..where((a) => a.filter.not()))
            .get();
    return _getInstalled(ignored);
  }

  @override
  Future<void> insert(entry) async {
    await db.applicationSettingTable.insertOnConflictUpdate(entry.companion);
  }
}
