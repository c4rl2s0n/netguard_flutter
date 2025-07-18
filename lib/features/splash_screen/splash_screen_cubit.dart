import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/common/service_locator/service_locator.dart' show configureDependencies;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'splash_screen_cubit.freezed.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState()) {
    _loadData();
  }

  late final SettingsCubit _settingsCubit;

  late final String applicationDocumentsDirectory;
  late final String databaseFilename;

  Future _loadData() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initializeFilepaths();
    _setupLogging();
    _enforcePortraitMode();

    // Load localization (Text resources)
    //await MusiciousLocalizations.load(AppLocalizationDelegate().supportedLocales.first);

    // Setup service locator
    await configureDependencies(
      applicationDocumentsDirectory,
      databaseFilename,
    );

    await _setupBlocs();

    // await CoreInitializer(
    //   _settingsCubit,
    //   _queueCubit,
    //   _playbackCubit,
    //   getIt<IMigrationRepository>(),
    // ).initializeApp();

    //getIt.registerSingleton<RouteObserver>(MusiciousRouteObserver(breadcrumbsCubit: _breadcrumbsCubit));

    emit(
      state.copyWith(
        loaded: true,
        //settingsCubit: _settingsCubit,
      ),
    );
  }

  Future _initializeFilepaths() async {
    // initialize filepaths and database
    Directory dir = await getApplicationDocumentsDirectory();
    applicationDocumentsDirectory = path.join(dir.path, 'netguard');
    databaseFilename = 'netguard.sqlite';
    await _prepareStorage(applicationDocumentsDirectory);
  }

  void _setupLogging() {
    // Error handling
    LoggingTools.setup(applicationDocumentsDirectory);
    FlutterError.onError = LoggingTools.onError;
  }

  void _enforcePortraitMode() {
    // Enforce Portrait-mode on mobile
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  Future _prepareStorage(String applicationDirectory) async {
    Directory dir = Directory(applicationDirectory);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }

  Future _setupBlocs() async {

    await sessionCubit.loadApplications();

    // _settingsCubit = getIt<SettingsCubit>();
    //
    // await _settingsCubit.initializeSettings(
    //   applicationDirectory: getIt<String>(instanceName: pkAppDirectory),
    //   databaseFilename: getIt<String>(instanceName: pkDbFile),
    // );

    // var snackBarNotifier = SnackBarNotifier(
    //   getIt<SnackBarService>(),
    //   _settingsCubit.appearanceSettings.themeDataLight,
    // );
    // getIt.registerSingleton<INotifier>(snackBarNotifier);
    // getIt.registerSingleton<SnackBarNotifier>(snackBarNotifier);
  }

  void finish() {
    emit(state.copyWith(done: true));
  }
}

@freezed
class SplashScreenState with _$SplashScreenState {
  const SplashScreenState({
    this.loaded = false,
    this.done = false,
    this.sessionCubit,
  });

  final bool loaded;
  final bool done;

  final SessionCubit? sessionCubit;

  bool get hasBlocs => sessionCubit != null;
}
