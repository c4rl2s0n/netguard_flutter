import 'dart:async';

import 'package:netguard/common/common.dart';
import 'package:netguard/common/service_locator/accessors.dart' as accessor;
import 'package:netguard/data/data.dart' as data;


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


  @override
  void updateVpnState(bool running) {
    accessor.sessionCubit.setVpnState(running);
  }

  final data.ITrafficLogRepository trafficLogRepository = accessor.trafficLogRepository;
  final StreamController<TrafficLog> _trafficLog = StreamController.broadcast();
  Stream<TrafficLog> get trafficLog => _trafficLog.stream;
  @override
  Future<void> logTraffic(TrafficLog log) async {
    _trafficLog.add(log);
  }
}
