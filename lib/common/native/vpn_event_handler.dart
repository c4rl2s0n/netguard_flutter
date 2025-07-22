import 'dart:async';

import 'package:netguard/common/common.dart';
import 'package:netguard/common/service_locator/accessors.dart' as accessor;
import 'package:netguard/data/data.dart' as data;

import 'native_bridge.g.dart';

class VpnEventHandlerImpl extends VpnEventHandler {
  final StreamController<String> _logs = StreamController.broadcast();
  Stream<String> get logs => _logs.stream;
  @override
  void logText(String message) {
    _logs.add(message);
  }

  final StreamController<String> _errors = StreamController.broadcast();
  Stream<String> get errors => _errors.stream;
  @override
  void logError(String errorCode, String message, Object details) {
    _errors.add("[$errorCode] $message\n${details.toString()}");
  }

  final StreamController<Packet> _packets = StreamController.broadcast();
  Stream<Packet> get packets => _packets.stream;
  @override
  Future<void> logPacket(Packet packet) async {
    _packets.add(packet);
  }

  // TODO: maybe not necessary...
  final data.IResourceRecordRepository resourceRecordRepository = accessor.resourceRecordRepository;
  @override
  Future<void> logDns(ResourceRecord record) async {
    await resourceRecordRepository.update(record);
  }

  @override
  void updateVpnState(String? session) {
    accessor.sessionCubit.setVpnSession(session);
  }

  final data.ITrafficLogRepository trafficLogRepository = accessor.trafficLogRepository;
  final StreamController<TrafficLog> _trafficLog = StreamController.broadcast();
  Stream<TrafficLog> get trafficLog => _trafficLog.stream;
  @override
  Future<void> logTraffic(TrafficLog log) async {
    if(log.packageName.notEmpty){
      print("Got log with packageName: ${log.packageName}");
    }
    _trafficLog.add(log);
    await trafficLogRepository.insert(log);
  }
}
