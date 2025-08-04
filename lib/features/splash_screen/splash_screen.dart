import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/features/features.dart';

import 'splash_screen_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashScreenCubit(),
      child: BlocConsumer<SplashScreenCubit, SplashScreenState>(
        listenWhen: (_, state) => state.loaded,
        listener: _performInteractiveSetup,
        buildWhen: (_, state) => state.done,
        builder: (context, state) => state.done ? _main(state) : _waiting(),
      ),
    );
  }

  Future _performInteractiveSetup(
    BuildContext context,
    SplashScreenState state,
  ) async {
    //SettingsCubit? settingsCubit = state.settingsCubit;
    await PermissionTools.requestNotificationPermission();
    await PermissionTools.requestBatteryOptimizationPermission();
    if (context.mounted) {
      context.read<SplashScreenCubit>().finish();
    }
  }

  Widget _main(SplashScreenState state) {
    return _registerGlobalBlocs(
      state,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) => MaterialApp(
          title: 'NetGuard',
          scaffoldMessengerKey: messengerKey,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          navigatorObservers: [routeObserver],

          theme: getTheme(settings.darkMode, flexScheme: settings.colorScheme),
          home: HomeScreen(),
        ),
      ),
    );
  }

  Widget _waiting() {
    return MaterialApp(
      theme: getTheme(true),
      home: Builder(
        builder: (context) {
          return Container(
            color: context.colors.background,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Image.asset("assets/images/ic_launcher.png"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CustomIcons.appIcon,
                        size: context.textTheme.headlineLarge.size,
                      ),
                      const Margin.horizontal(ThemeConstants.spacing),
                      Text("NetGuard", style: context.textTheme.headlineLarge),
                    ],
                  ),
                  const Margin.vertical(ThemeConstants.spacing),
                  CircularProgressIndicator(color: context.colors.onBackground),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Register Cubits, Locales and stuff that is required all around the place
  MultiBlocProvider _registerGlobalBlocs(
    SplashScreenState state, {
    required Widget child,
  }) {
    assert(state.done);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sessionCubit),
        BlocProvider(create: (_) => settingsCubit),
        BlocProvider(create: (_) => sessionCubit.state.sessionAnalysis),
      ],
      child: child,
    );
  }
}
