import 'dart:async';

import 'package:netguard/common/service_locator/accessors.dart' as accessor;
import 'package:netguard/data/data.dart' as data;

import 'native_bridge.g.dart';

class VpnEventHandlerImpl extends VpnEventHandler {
  final StreamController<String> _logs = StreamController();
  Stream<String> get logs => _logs.stream;
  @override
  void logText(String message) {
    _logs.add(message);
  }

  final StreamController<String> _errors = StreamController();
  Stream<String> get errors => _errors.stream;
  @override
  void logError(String errorCode, String message, Object details) {
    _errors.add("[$errorCode] $message\n${details.toString()}");
  }

  final StreamController<Packet> _packets = StreamController();
  Stream<Packet> get packets => _packets.stream;
  @override
  Future<void> logPacket(Packet packet) async {
    _packets.add(packet);
  }

  final data.IResourceRecordRepository resourceRecordRepository = accessor.resourceRecordRepository;
  @override
  Future<void> logDns(ResourceRecord record) async {
    await resourceRecordRepository.update(record);
  }

  @override
  void updateVpnState(bool running) {
    accessor.sessionCubit.setVpnState(running);
  }
}
