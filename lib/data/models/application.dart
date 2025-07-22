import 'package:netguard/common/native/native_bridge.g.dart' as native;
import 'models.dart';

class Application extends native.Application {
  Application({
    super.uid = -1,
    super.packageName = "",
    super.label = "",
    super.version = "",
    super.icon,
    super.system = false,
    this.setting,
    this.rules = const [],
  });
  Application.fromNative(native.Application app)
    : this(
        uid: app.uid,
        packageName: app.packageName,
        label: app.label,
        version: app.version,
        icon: app.icon,
        system: app.system,
        setting: null,
        rules: [],
      );

  ApplicationSetting? setting;
  List<Rule> rules;
}
