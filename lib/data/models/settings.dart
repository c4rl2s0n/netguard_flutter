import 'package:flex_color_scheme/flex_color_scheme.dart';

class Settings {
  Settings({
    this.id = 0,
    this.darkMode = true,
    this.colorScheme = FlexScheme.green,
    this.includeSystemApps = true,
    this.logTraffic = true,
    this.logCompactView = false,
    this.lastHostlistUpdate,
  });
  int id;
  bool darkMode;
  FlexScheme colorScheme;
  bool includeSystemApps;
  bool logTraffic;
  bool logCompactView;
  DateTime? lastHostlistUpdate;
}
