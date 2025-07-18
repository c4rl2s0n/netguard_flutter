import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:netguard/l10n/l10n.dart';
import 'package:netguard/common/common.dart';

extension ContextSettingsAccessorExtension on BuildContext {
  // BLoC
  SessionCubit get session => read<SessionCubit>();
  SettingsCubit get settings => read<SettingsCubit>();

  // Services
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
  NavigationService get navigator => NavigationService(this);

  // Theme
  ThemeData get themeData => Theme.of(this);
  CustomColors get customColors => themeData.extension<CustomColors>()!;
  ColorAccessor get colors =>
      ColorAccessor(themeData.colorScheme, defaultColors: customColors);
  //AppLocalizations get strings => AppLocalizations.of(this)!;
  PopupMenuThemeData get popupMenuTheme => themeData.popupMenuTheme;
  TextTheme get textTheme => themeData.textTheme;
  IconThemeData get iconTheme => themeData.iconTheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
