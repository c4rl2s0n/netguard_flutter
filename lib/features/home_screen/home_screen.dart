import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settings) => MaterialApp(
        title: 'NetGuard',
        scaffoldMessengerKey: messengerKey,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        navigatorObservers: [routeObserver],

        theme: getTheme(settings.darkMode, flexScheme: settings.colorScheme),
        home: Builder(builder: _home),
      ),
    );
  }

  Widget _home(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(
        context,
        title: "Home",
        actions: [PageComponentFactory.settingsNavigationButton(context)],
      ),
      body: _content(),
    );
  }

  static const double _buttonSize = 200;
  Widget _content() {
    return BlocBuilder<SessionCubit, SessionState>(
      buildWhen: (oldState, state) => oldState.running != state.running,
      builder: (context, session) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [if (session.running) _stop(context) else _start(context)],
        ),
      ),
    );
  }

  Widget _start(BuildContext context) {
    Widget icon = Icon(CustomIcons.inactive, size: context.textTheme.displaySmall?.fontSize,color: context.colors.warning,);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            icon,
            Text("Firewall disabled", style: context.textTheme.displaySmall),
            Transform.flip(flipX: true, child: icon),
          ],
        ),
        const Margin.vertical(ThemeConstants.spacing),
        IconButton(
          onPressed: sessionCubit.startVpn,
          style: IconButton.styleFrom(
            backgroundColor: context.colors.onBackground,
            foregroundColor: context.colors.positive,
          ),
          icon: Icon(CustomIcons.start, size: _buttonSize),
        ),
      ],
    );
  }

  Widget _stop(BuildContext context) {
    Widget icon = Icon(CustomIcons.active, size: context.textTheme.displaySmall?.fontSize, color: context.colors.positive,);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Transform.flip(flipX: true, child: icon),
            Text("Firewall is active", style: context.textTheme.displaySmall),
            icon,
          ],
        ),
        const Margin.vertical(ThemeConstants.spacing),
        IconButton(
          onPressed: sessionCubit.stopVpn,
          style: IconButton.styleFrom(
            backgroundColor: context.colors.onBackground,
            foregroundColor: context.colors.negative,
          ),
          icon: Icon(CustomIcons.stop, size: _buttonSize),
        ),
      ],
    );
  }
}
