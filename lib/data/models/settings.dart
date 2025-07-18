import 'package:flex_color_scheme/flex_color_scheme.dart';

class Settings {
  Settings({
    this.id = 0,
    this.darkMode = true,
    this.colorScheme = FlexScheme.green,
    this.includeSystemApps = true,
    this.lastBlacklistScan,
  });
  int id;
  bool darkMode;
  FlexScheme colorScheme;
  bool includeSystemApps;
  DateTime? lastBlacklistScan;
}
