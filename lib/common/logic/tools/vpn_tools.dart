import 'package:netguard/netguard.dart';
import 'package:netguard/common/native/native_bridge.g.dart' as native;

class VpnTools {
  static List<T> getRelevant<T>(List<T> elements, String Function(T) getPackageName){
    // ignore system apps, if they should not be blocked
    if (!settingsCubit.state.includeSystemApps) {
      elements.removeWhere((e) => sessionCubit.state.systemApplications.any((a) =>getPackageName(e) == a.packageName));
    }
    return elements;
  }
  static Future<VpnConfig> getConfig() async {
    VpnConfig config = VpnConfig(
      session: IdTools.generateUuid(),
      filteredPackages: await _getFilteredPackages(),
      dbPath: databaseFilepath,
    );
    return config;
  }

  static Future<List<String>> _getFilteredPackages() async {
    // get all the applications that should be filtered by firewall
    List<String> filtered = (await applicationSettingsRepository.getActive())
        .map((a) => a.packageName)
        .toList();
    filtered = getRelevant(filtered, (i) => i);
    return filtered.distinct;
  }
}
