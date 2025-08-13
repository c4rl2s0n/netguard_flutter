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
  _registerStrings(filepaths);

  // GlobalKeys
  getIt.registerSingleton<GlobalKey<ScaffoldMessengerState>>(messengerKey);
  getIt.registerLazySingleton<RouteObserver>(() => IsNavigationRootObserver());

  _registerDatabase();

  // Global Cubits
  var settingsCubit = SettingsCubit(settingsRepository);
  await settingsCubit.ensureLoaded();
  getIt.registerSingleton(settingsCubit);
  getIt.registerSingleton(SessionCubit(settingsCubit));

  // SnackBarService
  getIt.registerLazySingleton(() => SnackBarService(messengerKey));

  _registerPlatformChannels();

  // Injectable / MicroPackages
  getIt.init();
}

Future configureHeadlessDependencies(AppFilepaths filepaths) async {
  _registerStrings(filepaths);
  _registerDatabase();

  _registerPlatformChannels();

  // Injectable / MicroPackages
  getIt.init();
}

void _registerStrings(AppFilepaths filepaths){
  // Path strings
  getIt.registerSingleton<String>(
    filepaths.applicationDocumentsDirectory,
    instanceName: pkAppDirectory,
  );
  getIt.registerSingleton<String>(
    filepaths.databaseFilename,
    instanceName: pkDbFile,
  );
}

void _registerDatabase(){
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
}

void _registerPlatformChannels(){
  // Platform Channels
  getIt.registerSingleton(VpnController());
  VpnEventHandlerImpl eventHandler = VpnEventHandlerImpl();
  VpnEventHandler.setUp(eventHandler);
  getIt.registerSingleton(eventHandler);
}