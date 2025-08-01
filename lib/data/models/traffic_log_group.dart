import 'package:netguard/common/native/native_bridge.g.dart';
import 'package:netguard/features/session_logs/logic/session_logs_filter_cubit.dart';

// abstract class TrafficLogGroup {
//   TrafficLogGroup._({
//     required this.allowed,
//     required this.latest,
//     required this.count,
//     required this.size,
//   });
//   final bool allowed;
//   int latest;
//   int count;
//   int size;
//
//   void add(TrafficLog log) {
//     count++;
//     size += log.size;
//     if (log.time > latest) latest = log.time;
//   }
// }

class TrafficLogGroup {
  TrafficLogGroup._({
    required this.packageName,
    required this.protocol,
    required this.dport,
    required this.destination,
    required this.allowed,
    required this.latest,
    required this.count,
    required this.size,
  });
  TrafficLogGroup.fromLog(TrafficLog log)
    : this._(
        packageName: log.packageName,
        protocol: log.protocol,
        dport: log.dport,
        destination: log.host ?? log.ip,
        allowed: log.allowed,
        latest: log.time,
        count: 0,
        size: 0,
      );
  final String? packageName;
  final int protocol;
  final int dport;
  final String destination;
  final bool allowed;
  int latest;
  int count;
  int size;

  void add(TrafficLog log) {
    count++;
    size += log.size;
    if (log.time > latest) latest = log.time;
  }
}

class TrafficLogGroups {
  TrafficLogGroups();
  final Map<String?, Map<String, Map<int, TrafficLogGroup>>> _groups = {};

  void clear() {
    _groups.clear();
  }

  void insert(TrafficLog event) {
    Map<String, Map<int, TrafficLogGroup>> byDest = _groups.putIfAbsent(
      event.packageName,
      () => <String, Map<int, TrafficLogGroup>>{},
    );
    Map<int, TrafficLogGroup> byProtocol = byDest.putIfAbsent(
      event.host ?? event.ip,
      () => <int, TrafficLogGroup>{},
    );
    var group = byProtocol.putIfAbsent(
      event.protocol,
      () => TrafficLogGroup.fromLog(event),
    );
    group.add(event);
  }

  List<TrafficLogGroup> list({String? packageName}) {
    List<TrafficLogGroup> groups = [];
    void addByPackage(Map<String, Map<int, TrafficLogGroup>> byPackage) {
      for (var byDest in byPackage.values) {
        groups.addAll(byDest.values);
      }
    }

    if (packageName != null && packageName != FilterStrings.all) {
      if (packageName == FilterStrings.unknown) packageName = null;
      if (_groups.containsKey(packageName)) addByPackage(_groups[packageName]!);
    } else {
      for (Map<String, Map<int, TrafficLogGroup>> byPackage in _groups.values) {
        addByPackage(byPackage);
      }
    }

    groups.sort((a, b) => b.latest.compareTo(a.latest));
    return groups;
  }
}
