import 'package:flutter/widgets.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/common/service_locator/service_locator.dart';
import 'package:path/path.dart';


VpnController get vpnController => getIt<VpnController>();
VpnEventHandler get vpnEventHandler => getIt<VpnEventHandlerImpl>();
SnackBarService get snackBarService => getIt<SnackBarService>();
RouteObserver get routeObserver => getIt<RouteObserver>();

String get documentsDirectory => getIt<String>(instanceName: pkAppDirectory);
String get databaseFilename => getIt<String>(instanceName: pkDbFile);
String get databaseFilepath => join(documentsDirectory, databaseFilename);

SettingsCubit get settingsCubit => getIt<SettingsCubit>();
SessionCubit get sessionCubit => getIt<SessionCubit>();

IApplicationSettingsRepository get applicationSettingsRepository => getIt<IApplicationSettingsRepository>();
IBlacklistRepository get blacklistRepository => getIt<IBlacklistRepository>();
IGlobalRuleSourceRepository get globalRuleSourceRepository => getIt<IGlobalRuleSourceRepository>();
IResourceRecordRepository get resourceRecordRepository => getIt<IResourceRecordRepository>();
IRulesRepository get rulesRepository => getIt<IRulesRepository>();
ISettingsRepository get settingsRepository => getIt<ISettingsRepository>();
