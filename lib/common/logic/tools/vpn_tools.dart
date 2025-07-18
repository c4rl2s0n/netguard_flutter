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
      filteredPackages: await _getFilteredPackages(),
      packageRules: await _getPackageRules(),
      globalRule: await _getGlobalRule(),
    );
    return config;
  }

  static Future<List<native.Rule>> _getPackageRules() async{
    // get all the applications that should be ignored by firewall
    List<String> active = (await applicationSettingsRepository.getActive())
        .map((a) => a.packageName)
        .toList();
    active = getRelevant(active, (a) => a);

    List<native.Rule> rules = [];
    IRulesRepository rr = rulesRepository;
    for(var packageName in active){
      rules.addAll(await rr.getForPackage(packageName));
    }
    return rules;
  }
  static Future<native.Rule> _getGlobalRule() async {
    List<BlacklistEntry> blacklist = await blacklistRepository.getGeneric();
    return native.Rule(
      packageName: null,
      blockedHosts: blacklist
          .where((b) => b.type == BlacklistType.host)
          .map((b) => b.target)
          .toList(),
      blockedIPs: blacklist
          .where((b) => b.type == BlacklistType.ip)
          .map((b) => b.target)
          .toList(),
    );
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
