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
  void updateSettings(VpnConfig settings);
  List<Application> getApplications();
}

@FlutterApi()
abstract class VpnEventHandler {
  void logText(String message);
  void logError(String errorCode, String message, Object details);
  void updateVpnState(bool running);
  @async
  void logPacket(Packet packet);
  @async
  void logDns(ResourceRecord record);
}

/// MODELS
class VpnConfig {
  VpnConfig({
    this.filteredPackages = const [],
    this.blockedPackages = const [],
    this.packageRules = const [],
    this.globalRule,
    this.filterUdp = true,
    this.logLevel = 5,
  });
  /// List of PackageNames that are filtered by the firewall
  List<String> filteredPackages;

  /// List of PackageNames that are completely blocked by the firewall
  List<String> blockedPackages;

  /// List of rules that apply for individual packages
  List<Rule> packageRules;

  /// Rule that applies for all applications
  Rule? globalRule;

  bool filterUdp;

  int logLevel;
}

class Application{
  Application({
    this.uid = -1,
    this.packageName = "",
    this.label = "",
    this.version = "",
    this.icon,
    this.system = false,
    this.setting,
  });
  int uid;
  String packageName;
  String label;
  String version;
  Uint8List? icon;
  bool system;
  ApplicationSetting? setting;
}

class ApplicationSetting {
  ApplicationSetting({required this.packageName, this.filter = false});
  String packageName;
  bool filter;
}

class Forward {
  Forward({
    this.protocol = -1,
    this.dport = -1,
    this.raddr = "",
    this.rport = -1,
    this.ruid = -1,
  });
  int protocol;
  int dport;
  String raddr;
  int rport;
  int ruid;
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

class Rule {
  Rule({
    this.blockedHosts = const [],
    this.blockedIPs = const [],
  });
  String? packageName;
  List<String> blockedHosts;
  List<String> blockedIPs;
}

class Usage {
  Usage({
    this.time = 0,
    this.version = 0,
    this.protocol = 0,
    this.daddr = "",
    this.dport = 0,
    this.uid = 0,
    this.sent = 0,
    this.received = 0,
  });
  int time;
  int version;
  int protocol;
  String daddr;
  int dport;
  int uid;
  int sent;
  int received;
}

class Version {
  Version(this.version);
  String version;
}
