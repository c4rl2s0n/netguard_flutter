import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/common/service_locator/accessors.dart';
import 'package:netguard/features/features.dart';
import 'package:netguard/main.dart';

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
    PermissionTools.requestNotificationPermission();
    PermissionTools.requestNotificationPermission();
    if (context.mounted) {
      context.read<SplashScreenCubit>().finish();
    }
  }

  Widget _main(SplashScreenState state) {
    return _registerGlobalBlocs(state, child: HomeScreen());
  }

  Widget _waiting() {
    return MaterialApp(
      home: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset("assets/images/ic_launcher.png"),
              CircularProgressIndicator(),
            ],
          ),
        ),
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
      ],
      child: child,
    );
  }
}
