import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

import 'service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
  includeMicroPackages: false,
  //externalPackageModulesBefore: [ExternalModule(DataRepositoriesPackageModule)],
  //externalPackageModulesAfter: [ExternalModule(CoreLogicPackageModule)],
)
Future configureDependencies(AppFilepaths filepaths) async {
  // Path strings
  getIt.registerSingleton<String>(
    filepaths.applicationDocumentsDirectory,
    instanceName: pkAppDirectory,
  );
  getIt.registerSingleton<String>(
    filepaths.databaseFilename,
    instanceName: pkDbFile,
  );

  // GlobalKeys
  getIt.registerSingleton<GlobalKey<ScaffoldMessengerState>>(messengerKey);
  getIt.registerLazySingleton<RouteObserver>(() => IsNavigationRootObserver());

  // Database
  var db = AppDatabase();
  getIt.registerSingleton(db);
  getIt.registerCachedFactory<IApplicationSettingsRepository>(
    () => ApplicationSettingsRepository(db),
  );
  getIt.registerCachedFactory<IHostsRepository>(() => HostsRepository(db));
  getIt.registerCachedFactory<IGlobalRuleSourceRepository>(
    () => GlobalRuleSourceRepository(db),
  );
  getIt.registerCachedFactory<ITrafficLogRepository>(
    () => TrafficLogRepository(db),
  );
  getIt.registerCachedFactory<ITrafficStatisticsRepository>(
    () => TrafficStatisticsRepository(db),
  );
  getIt.registerCachedFactory<IResourceRecordRepository>(
    () => ResourceRecordRepository(db),
  );
  getIt.registerCachedFactory<IRulesRepository>(() => RulesRepository(db));
  getIt.registerCachedFactory<ISettingsRepository>(
    () => SettingsRepository(db),
  );

  // Global Cubits
  var settingsCubit = SettingsCubit(settingsRepository);
  await settingsCubit.ensureLoaded();
  getIt.registerSingleton(settingsCubit);
  getIt.registerSingleton(SessionCubit(settingsCubit));

  // SnackBarService
  getIt.registerLazySingleton(() => SnackBarService(messengerKey));

  // Platform Channels
  getIt.registerSingleton(VpnController());
  VpnEventHandlerImpl eventHandler = VpnEventHandlerImpl();
  VpnEventHandler.setUp(eventHandler);
  getIt.registerSingleton(eventHandler);

  // Injectable / MicroPackages
  getIt.init();
}

Future configureHeadlessDependencies(AppFilepaths filepaths) async {
  // Path strings
  getIt.registerSingleton<String>(
    filepaths.applicationDocumentsDirectory,
    instanceName: pkAppDirectory,
  );
  getIt.registerSingleton<String>(
    filepaths.databaseFilename,
    instanceName: pkDbFile,
  );

  // Database
  var db = AppDatabase();
  getIt.registerSingleton(db);
  getIt.registerCachedFactory<IApplicationSettingsRepository>(
    () => ApplicationSettingsRepository(db),
  );
  getIt.registerCachedFactory<IHostsRepository>(() => HostsRepository(db));
  getIt.registerCachedFactory<IGlobalRuleSourceRepository>(
    () => GlobalRuleSourceRepository(db),
  );
  getIt.registerCachedFactory<ITrafficStatisticsRepository>(
    () => TrafficStatisticsRepository(db),
  );
  getIt.registerCachedFactory<IResourceRecordRepository>(
    () => ResourceRecordRepository(db),
  );
  getIt.registerCachedFactory<IRulesRepository>(() => RulesRepository(db));
  getIt.registerCachedFactory<ISettingsRepository>(
    () => SettingsRepository(db),
  );

  // Platform Channels
  getIt.registerSingleton(VpnController());
  VpnEventHandlerImpl eventHandler = VpnEventHandlerImpl();
  VpnEventHandler.setUp(eventHandler);
  getIt.registerSingleton(eventHandler);

  // Injectable / MicroPackages
  getIt.init();
}
