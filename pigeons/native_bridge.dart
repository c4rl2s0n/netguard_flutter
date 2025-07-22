import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/common/native/native_bridge.g.dart',
    dartOptions: DartOptions(),
    javaOut: 'android/app/src/main/java/eu/flutter/netguard/NativeBridge.java',
    javaOptions: JavaOptions(package: "eu.flutter.netguard"),
    dartPackageName: 'pigeon_example_package',
  ),
)
@HostApi()
abstract class VpnController {
  void startVpn(VpnConfig settings);
  void stopVpn();
  bool isRunning();
  String? getSession();
  void updateSettings(VpnConfig settings);
  List<Application> getApplications();
}

@FlutterApi()
abstract class VpnEventHandler {
  void logText(String message);
  void logError(String errorCode, String message, Object details);
  void updateVpnState(String? sessionId);
  @async
  void logPacket(Packet packet);
  @async
  void logDns(ResourceRecord record);
  @async
  void logTraffic(TrafficLog log);
}

/// MODELS
class VpnConfig {
  VpnConfig({
    required this.session,
    this.filteredPackages = const [],
    this.blockedPackages = const [],
    required this.dbPath,
    this.filterUdp = true,
    this.logLevel = 5,
  });

  /// Identifier for the session to allow matching traffic log to session
  String session;

  /// List of PackageNames that are filtered by the firewall
  List<String> filteredPackages;

  /// List of PackageNames that are completely blocked by the firewall
  List<String> blockedPackages;

  /// path of the sqlite database, so native code can read from it directly
  String dbPath;

  bool filterUdp;

  int logLevel;
}

class Application {
  Application({
    this.uid = -1,
    this.packageName = "",
    this.label = "",
    this.version = "",
    this.icon,
    this.system = false,
  });
  int uid;
  String packageName;
  String label;
  String version;
  Uint8List? icon;
  bool system;
}

class Packet {
  Packet({
    this.time = 0,
    this.version = 0,
    this.protocol = 0,
    this.flags = "",
    this.saddr = "",
    this.sport = 0,
    this.daddr = "",
    this.dport = 0,
    this.data = "",
    this.uid = 0,
    this.packageName,
    this.allowed = true,
  });
  int time;
  int version;
  int protocol;
  String flags;
  String saddr;
  int sport;
  String daddr;
  int dport;
  String data;
  int uid;
  String? packageName;
  bool allowed;
}

class ResourceRecord {
  ResourceRecord({
    this.time = 0,
    this.qName = "",
    this.aName = "",
    this.resource = "",
    this.ttl,
    this.uid,
    this.packageName,
  });
  int time;
  String qName;
  String aName;
  String resource;
  int? ttl;
  int? uid;
  String? packageName;
}

enum RuleType { blacklist, whitelist }

class Rule {
  Rule({
    required this.type,
    required this.blockQuic,
    required this.hosts,
    required this.ips,
  });
  String? packageName;
  RuleType type;
  bool blockQuic;
  Map<String, bool> hosts;
  Map<String, bool> ips;
}

class TrafficLog {
  TrafficLog({
    required this.time,
    required this.session,
    this.protocol = 0,
    this.ip = "",
    this.host,
    this.packageName,
    required this.allowed,
  });
  int time;
  String session;
  int protocol;
  String ip;
  String? host;
  String? packageName;
  bool allowed;
}

class Version {
  Version(this.version);
  String version;
}
