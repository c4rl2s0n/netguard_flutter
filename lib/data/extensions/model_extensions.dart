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
  void addLog(TrafficLog log){
    if(log.allowed) {
      packetCountAllowed++;
      packetSizeAllowed += log.size;
    }
    if(log.blocked){
      packetCountBlocked++;
      packetSizeBlocked += log.size;
    }
  }
  void updatePackageInfoFromMap(Iterable<TrafficLogByApplication> analysisByApplication){
    mostTrafficPackage = analysisByApplication.nonNulls.sortedBy((a) => a.count).lastOrNull?.application?.packageName;
    mostBlockedPackage = analysisByApplication.nonNulls.sortedBy((a) => a.countBlocked).lastOrNull?.application?.packageName;
  }
}

extension TrafficLogExtension on TrafficLog {
  bool get blocked => !allowed;
  String get destination => host ?? ip;
}


