
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/common/service_locator/service_locator.dart';

class FlutterHeadless {

  late final SettingsCubit settingsCubit;
  late final SessionCubit sessionCubit;
  late final StreamSubscription closeEngineListener;

  Future run() async {
    WidgetsFlutterBinding.ensureInitialized();

    AppFilepaths filepaths = await SetupTools.getFilepaths();
    SetupTools.setupLogging(filepaths.applicationDocumentsDirectory);

    configureHeadlessDependencies(filepaths);

    closeEngineListener = vpnEventHandler.closeEngineStream.listen(onCloseEngine);

    // Setup SessionCubit to handle trafficLogs in the background!
    settingsCubit = SettingsCubit(settingsRepository);
    await settingsCubit.ensureLoaded();
    sessionCubit = SessionCubit(settingsCubit);
    await sessionCubit.load();

    // Keep alive by running an empty widget (optional)
    runApp(Container());
  }


  void onCloseEngine(void event) async {
    await closeEngineListener.cancel();
    await settingsCubit.close();
    await sessionCubit.close();
    await database.close();
  }
}