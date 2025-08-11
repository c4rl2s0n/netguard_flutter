import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

extension ApplicationExtension on Application? {
  String get label => this?.label ?? "Unknown";
}

extension SessionStatisticsExtension on SessionStatistics {
  int get packetCount => packetCountAllowed + packetCountBlocked;

  int get packetSize => packetSizeAllowed + packetSizeBlocked;

  void addLog(TrafficLog log) {
    if (log.allowed) {
      packetCountAllowed++;
      packetSizeAllowed += log.size;
    }
    if (log.blocked) {
      packetCountBlocked++;
      packetSizeBlocked += log.size;
    }
  }
}
extension PackageStatisticsExtension on PackageStatistics {
  int get packetCount => packetCountAllowed + packetCountBlocked;
  int get packetSize => packetSizeAllowed + packetSizeBlocked;

  void addLog(TrafficLog log) {
    if (log.allowed) {
      packetCountAllowed++;
      packetSizeAllowed += log.size;
    }
    if (log.blocked) {
      packetCountBlocked++;
      packetSizeBlocked += log.size;
    }
  }
}

extension LiveSessionStatisticsExtension on LiveSessionStatistics {
  void addLog(TrafficLog log) {
    SessionStatisticsExtension(this).addLog(log);
    var packageStatistics = this.packageStatistics.putIfAbsent(
      log.packageName,
      () => PackageStatistics(packageName: log.packageName),
    );
    packageStatistics.addLog(log);

    mostTrafficPackage = this.packageStatistics.values
        .sortedBy((a) => a.packetSize)
        .where((a) => a.packetSize > 0)
        .lastOrNull;
    mostBlockedPackage = this.packageStatistics.values
        .sortedBy((a) => a.packetCountBlocked)
        .where((a) => a.packetCountBlocked > 0)
        .lastOrNull;
  }
}

extension TrafficLogExtension on TrafficLog {
  bool get blocked => !allowed;
  String get destination => host ?? ip;
}

extension VpnConfigExtension on VpnConfig? {
  bool get running => this != null && this!.session.notEmpty && !this!.finished;
}
