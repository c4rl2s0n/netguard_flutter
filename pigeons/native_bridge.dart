import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/native_bridge.g.dart',
    dartOptions: DartOptions(),
    javaOut: 'android/app/src/main/java/eu/flutter/netguard/NativeBridge.java',
    javaOptions: JavaOptions(package: "eu.flutter.netguard"),
    dartPackageName: 'pigeon_example_package',
  ),
)
@HostApi()
abstract class VpnController {
  void startVpn(VpnSettings settings);
  void stopVpn();
  bool isRunning();
  void updateSettings(VpnSettings settings);
}

@FlutterApi()
abstract class VpnEventHandler {
  void logText(String message);
  void logError(String errorCode, String message, Object details);
  void sendEvent(Packet packet);
}

/// MODELS
class VpnSettings {
  VpnSettings({this.blockTraffic = false});
  bool blockTraffic;
}

class Allowed {
  Allowed({this.raddr = null, this.rport = null});
  String? raddr;
  int? rport;
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
  bool allowed;
}

class ResourceRecord {
  ResourceRecord({
    this.time = 0,
    this.qName = "",
    this.aName = "",
    this.resource = "",
    this.ttl = 0,
    this.uid = -1,
  });
  int time;
  String qName;
  String aName;
  String resource;
  int ttl;
  int uid;
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

class Version{
  Version(this.version);
  String version;
}