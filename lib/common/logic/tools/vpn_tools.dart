import 'package:flutter/foundation.dart';
import 'package:netguard/netguard.dart';

class VpnTools {
  static List<T> getRelevant<T>(
    List<T> elements,
    String Function(T) getPackageName,
  ) {
    // ignore system apps, if they should not be blocked
    if (!settingsCubit.state.includeSystemApps) {
      elements.removeWhere(
        (e) => sessionCubit.state.systemApplications.any(
          (a) => getPackageName(e) == a.packageName,
        ),
      );
    }
    return elements;
  }

  static Future<VpnConfig> getConfig(Settings settings) async {
    List<ApplicationSetting> activeApplications = getRelevant(
      await applicationSettingsRepository.getActive(),
      (a) => a.packageName,
    );
    var filtered = activeApplications.map((a) => a.packageName).toList();
    VpnConfig config = VpnConfig(
      session: IdTools.generateUuid(),
      logTraffic: settings.logTraffic,
      dbPath: databaseFilepath,
      filteredPackages: filtered,
      logLevel: kDebugMode ? 1 : 5,
    );
    return config;
  }
}
