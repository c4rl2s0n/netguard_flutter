import 'package:netguard/common/native/native_bridge.g.dart' as native;

class Rule extends native.Rule {
  Rule({
    required this.id,
    this.targetVersion,
    this.description,
    this.active = true,
    super.packageName,
    super.blockedHosts = const [],
    super.blockedIPs = const [],
  });

  String id;
  String? targetVersion;
  String? description;
  bool active;
}
