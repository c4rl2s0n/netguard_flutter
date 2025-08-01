import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/features/settings/settings_view.dart';

class PageComponentFactory {
  static Widget scaffold(
    BuildContext context, {
    required AppBar appBar,
    required Widget body,
    bool withPadding = true,
  }) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: appBar,
      drawer: NavDrawer(),
      body: Padding(
        padding: withPadding
            ? const EdgeInsets.all(ThemeConstants.spacing)
            : EdgeInsets.zero,
        child: body,
      ),
    );
  }

  static AppBar appBar(
    BuildContext context, {
    required String title,
    List<Widget>? actions,
    bool showDeviceInfo = true,
  }) {
    ColorAccessor colors = context.colors;
    Color background = colors.appBar;
    Color foreground = colors.onAppBar;
    IconThemeData iconTheme = context.themeData.iconTheme.copyWith(
      color: foreground,
    );

    return AppBar(
      toolbarHeight: 45,
      titleTextStyle: context.textTheme.titleLarge.withColor(foreground),
      title: Text(title),
      leading: IconTheme(data: iconTheme, child: _appBarLeading()),
      automaticallyImplyLeading: true,
      actionsIconTheme: iconTheme,
      actionsPadding: EdgeInsets.zero, // TODO: check
      actions: [_sessionButton(), ...actions ?? []],
      iconTheme: iconTheme.copyWith(size: 20),

      backgroundColor: background,
    );
  }

  static Widget _appBarLeading() {
    return Builder(
      builder: (context) => ModalRoute.of(context)?.canPop ?? false
          ? IconButton(
              onPressed: () => context.navigator.pop(),
              icon: const Icon(Icons.arrow_back),
            )
          : IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu),
            ),
    );
  }

  static Widget _sessionButton() {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) => state.running
          ? IconButton(
              onPressed: () async {
                if (await ConfirmationDialog.ask(
                  context,
                  title: "Are you sure?",
                  content: "Do you want to stop the firewall?",
                )) {
                  await sessionCubit.stopVpn();
                }
              },
              icon: Icon(CustomIcons.active),
            )
          : VpnLauncher(
              (launchVpn) => IconButton(
                onPressed: () => launchVpn(context),
                icon: Icon(CustomIcons.inactive, color: context.colors.warning),
              ),
            ),
    );
  }

  static Widget appBarIconButton(
    Function(BuildContext context)? onTap,
    IconData icon,
  ) {
    return Builder(
      builder: (context) {
        return IconButton(
          onPressed: onTap != null ? () => onTap(context) : null,
          icon: Icon(icon),
        );
      },
    );
  }

  static Widget navigationIconButton(
    Widget Function()? getDestination,
    IconData icon,
  ) {
    return appBarIconButton(
      getDestination != null
          ? (context) => context.navigator.navigateTo(getDestination())
          : null,
      icon,
    );
  }

  static Widget settingsNavigationButton() =>
      PageComponentFactory.navigationIconButton(
        () => const SettingsView(),
        CustomIcons.settings,
      );
}
