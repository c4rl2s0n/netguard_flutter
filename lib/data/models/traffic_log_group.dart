import 'package:netguard/common/common.dart';
import 'package:netguard/common/native/native_bridge.g.dart';
import 'package:netguard/common/constants.dart';

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

  List<TrafficLogGroup> list({List<String?>? packageNames}) {
    List<TrafficLogGroup> groups = [];
    void addByPackage(Map<String, Map<int, TrafficLogGroup>> byPackage) {
      for (var byDest in byPackage.values) {
        groups.addAll(byDest.values);
      }
    }

    if (packageNames.notEmpty) {
      for (var packageName in packageNames!) {
        if (_groups.containsKey(packageName)) {
          addByPackage(_groups[packageName]!);
        }
      }
    } else {
      for (Map<String, Map<int, TrafficLogGroup>> byPackage in _groups.values) {
        addByPackage(byPackage);
      }
    }

    groups.sort((a, b) => b.latest.compareTo(a.latest));
    return groups;
  }
}
