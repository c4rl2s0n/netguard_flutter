import 'package:drift/isolate.dart';
import 'package:flutter/widgets.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/common/service_locator/service_locator.dart';
import 'package:path/path.dart';


VpnController get vpnController => getIt<VpnController>();
VpnEventHandlerImpl get vpnEventHandler => getIt<VpnEventHandlerImpl>();
SnackBarService get snackBarService => getIt<SnackBarService>();
RouteObserver get routeObserver => getIt<RouteObserver>();

String get documentsDirectory => getIt<String>(instanceName: pkAppDirectory);
String get databaseFilename => getIt<String>(instanceName: pkDbFile);
String get databaseFilepath => join(documentsDirectory, databaseFilename);

SettingsCubit get settingsCubit => getIt<SettingsCubit>();
SessionCubit get sessionCubit => getIt<SessionCubit>();

AppDatabase get database => getIt<AppDatabase>();
Future<DriftIsolate> get databaseConnection async => await database.serializableConnection();
IApplicationSettingsRepository get applicationSettingsRepository => getIt<IApplicationSettingsRepository>();
IHostsRepository get hostsRepository => getIt<IHostsRepository>();
IGlobalRuleSourceRepository get globalRuleSourceRepository => getIt<IGlobalRuleSourceRepository>();
IPackageStatisticsRepository get packageStatisticsRepository => getIt<IPackageStatisticsRepository>();
IResourceRecordRepository get resourceRecordRepository => getIt<IResourceRecordRepository>();
IRulesRepository get rulesRepository => getIt<IRulesRepository>();
ISettingsRepository get settingsRepository => getIt<ISettingsRepository>();
ITrafficLogRepository get trafficLogRepository => getIt<ITrafficLogRepository>();
