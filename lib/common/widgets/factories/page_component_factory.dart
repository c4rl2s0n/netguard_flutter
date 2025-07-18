import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return SelectionArea(
      // hide contextMenu
      contextMenuBuilder: (_, __) => const SizedBox.shrink(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: appBar,
        drawer: NavDrawer(),
        body: Padding(
          padding: withPadding
              ? const EdgeInsets.all(ThemeConstants.spacing)
              : EdgeInsets.zero,
          child: body,
        ),
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
      titleTextStyle: context.textTheme.headlineLarge.withColor(foreground),
      title: _appBarTitle(context, title),
      leading: IconTheme(data: iconTheme, child: _appBarLeading()),
      actionsIconTheme: iconTheme,
      actions: actions,
      iconTheme: iconTheme.copyWith(size: 20),

      backgroundColor: background,
    );
  }

  static Widget _appBarTitle(BuildContext context, String title) {
    TextStyle? style = context.textTheme.headlineLarge.withColor(
      context.colors.onAppBar,
    );
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) => Row(
        children: [
          Text(title, style: style),
          if (state.running)
            IconButton(
              onPressed: () async {
                if (await ConfirmationDialog.ask(
                  context,
                  title: "Are you sure?",
                  content: "Do you want to stop the firewall?",
                )) {
                  await sessionCubit.stopVpn();
                }
              },
              icon: Icon(CustomIcons.active, size: style.size),
            )
          else
            IconButton(
              onPressed: sessionCubit.startVpn,
              icon: Icon(
                CustomIcons.inactive,
                size: style.size,
                color: context.colors.warning,
              ),
            ),
        ],
      ),
    );
  }

  static Widget _appBarLeading() {
    return Builder(
      builder: (context) => IsNavigationRootObserver.isRoot
          ? IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu),
            )
          : IconButton(
              onPressed: () => context.navigator.pop(),
              icon: Icon(Icons.arrow_back),
            ),
    );
  }

  static Widget navigationIconButton(
    BuildContext context,
    Widget Function()? getDestination,
    IconData icon,
  ) {
    return IconButton(
      onPressed: getDestination != null
          ? () => context.navigator.navigateTo(getDestination())
          : null,
      icon: Icon(icon),
    );
  }

  static Widget settingsNavigationButton(BuildContext context) =>
      PageComponentFactory.navigationIconButton(
        context,
        () => const SettingsView(),
        CustomIcons.settings,
      );
}
