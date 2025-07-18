import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

ThemeData getTheme(
  bool dark, {
  FlexScheme? flexScheme,
  String? fontFamily,
  CustomColors defaultColors = const CustomColors(),
  Iterable<ThemeExtension<dynamic>>? extensions,
}) {
  FlexSubThemesData subThemesData = const FlexSubThemesData(
    dropdownMenuTextStyle: TextStyle(fontSize: 25),
    menuButtonTextStyle: WidgetStatePropertyAll(TextStyle(fontSize: 12)),
  );
  ThemeData theme =
      (dark
              ? FlexColorScheme.dark(
                  useMaterial3: true,
                  scheme: flexScheme,
                  subThemesData: subThemesData,
                  fontFamily: fontFamily,
                )
              : FlexColorScheme.light(
                  useMaterial3: true,
                  scheme: flexScheme,
                  subThemesData: subThemesData,
                  fontFamily: fontFamily,
                ))
          .toTheme;
  ColorAccessor colors = ColorAccessor(
    theme.colorScheme,
    defaultColors: defaultColors,
  );
  var textTheme = theme.textTheme;
  TextStyle? menuItemTextStyle = textTheme.labelLarge;
  var menuButtonTheme = MenuButtonThemeData(
    style: theme.menuButtonTheme.style?.copyWith(
      textStyle: WidgetStateProperty.all(menuItemTextStyle),
    ),
  );
  var dropdownMenuTheme = theme.dropdownMenuTheme.copyWith(
    textStyle: menuItemTextStyle,
  );
  var pageTransitionsTheme = const PageTransitionsTheme(
    builders: {
      TargetPlatform.linux: const ZoomPageTransitionsBuilder(),
      TargetPlatform.windows: const FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.android: const FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: const CupertinoPageTransitionsBuilder(),
    },
  );

  var iconTheme = theme.iconTheme.copyWith(size: 24);

  return theme.copyWith(
    menuButtonTheme: menuButtonTheme,
    dropdownMenuTheme: dropdownMenuTheme,
    pageTransitionsTheme: pageTransitionsTheme,
    navigationRailTheme: _navigationRailTheme(theme, colors, iconTheme),
    iconTheme: iconTheme,
    hoverColor: colors.primaryContainer,
    extensions: [defaultColors, if (extensions != null) ...extensions],
  );
}

NavigationRailThemeData _navigationRailTheme(
  ThemeData theme,
  ColorAccessor colors,
  IconThemeData? iconTheme,
) {
  Color background = colors.primaryContainer;
  Color foreground = colors.onPrimaryContainer;
  var textTheme = theme.textTheme;
  var labelStyle = textTheme.labelSmall.withColor(foreground);
  iconTheme = iconTheme.withColor(foreground);
  return NavigationRailThemeData(
    backgroundColor: background,
    selectedLabelTextStyle: labelStyle,
    selectedIconTheme: iconTheme.withColor(colors.onTertiary),
    unselectedLabelTextStyle: labelStyle.withOpacity(
      ThemeConstants.lightColorOpacity,
    ),
    unselectedIconTheme: iconTheme.withOpacity(
      ThemeConstants.lightColorOpacity,
    ),
    indicatorColor: colors.tertiary,
    useIndicator: true,
    labelType: NavigationRailLabelType.all,
  );
}
