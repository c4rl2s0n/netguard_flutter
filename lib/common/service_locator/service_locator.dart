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
Future configureDependencies(
  String applicationDocumentsDirectory,
  String databaseFilename,
) async {
  // Path strings
  getIt.registerSingleton<String>(
    applicationDocumentsDirectory,
    instanceName: pkAppDirectory,
  );
  getIt.registerSingleton<String>(databaseFilename, instanceName: pkDbFile);

  // GlobalKeys
  getIt.registerSingleton<GlobalKey<ScaffoldMessengerState>>(messengerKey);
  getIt.registerLazySingleton<RouteObserver>(() => IsNavigationRootObserver());

  // Database
  getIt.registerSingleton(AppDatabase());
  getIt.registerCachedFactory<IApplicationSettingsRepository>(() => ApplicationSettingsRepository());
  getIt.registerCachedFactory<IBlacklistRepository>(() => BlacklistRepository());
  getIt.registerCachedFactory<IGlobalRuleSourceRepository>(() => GlobalRuleSourceRepository());
  getIt.registerCachedFactory<IResourceRecordRepository>(() => ResourceRecordRepository());
  getIt.registerCachedFactory<IRulesRepository>(() => RulesRepository());
  getIt.registerCachedFactory<ISettingsRepository>(() => SettingsRepository());

  // Global Cubits
  getIt.registerSingleton(SettingsCubit(settingsRepository));
  getIt.registerSingleton(SessionCubit());

  // SnackBarService
  getIt.registerLazySingleton(() => SnackBarService(messengerKey));

  // Platform Channels
  getIt.registerSingleton(VpnController());
  var eventHandler = VpnEventHandlerImpl();
  VpnEventHandler.setUp(eventHandler);


  // Injectable / MicroPackages
  getIt.init();
}
