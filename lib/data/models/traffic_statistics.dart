import 'package:netguard/data/data.dart';

class TrafficStatistics {
  TrafficStatistics({
    required this.packageName,
    required this.endpoint,
    required this.endpointType,
    this.packetCountAllowed = 0,
    this.packetSizeAllowed = 0,
    this.packetCountBlocked = 0,
    this.packetSizeBlocked = 0,
  });
  String? packageName;
  String endpoint;
  EndpointType endpointType;
  int packetCountAllowed;
  int packetSizeAllowed;
  int packetCountBlocked;
  int packetSizeBlocked;

}

