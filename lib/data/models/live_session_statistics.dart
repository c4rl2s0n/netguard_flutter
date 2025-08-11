import 'package:netguard/common/common.dart';

class LiveSessionStatistics extends SessionStatistics {
  LiveSessionStatistics._({
    super.packetCountAllowed = 0,
    super.packetSizeAllowed = 0,
    super.packetCountBlocked = 0,
    super.packetSizeBlocked = 0,
    super.mostBlockedPackage,
    super.mostTrafficPackage,
    this.packageStatistics = const {},
  });
  factory LiveSessionStatistics.empty() => LiveSessionStatistics._(packageStatistics: {});
  Map<String?, PackageStatistics> packageStatistics;
}
