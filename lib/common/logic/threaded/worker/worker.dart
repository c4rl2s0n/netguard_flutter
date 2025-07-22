import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

import '../tasks/isolated_task.dart';

abstract class Worker {
  late SendPort sendPort;
  late Isolate _isolate;

  final _isolateReady = Completer<void>();

  bool get isReady => _isolateReady.isCompleted;

  Future<void> get isolateReady => _isolateReady.future;

  final Function(SendPort sendPort) isolateEntry;

  Worker({required this.isolateEntry}) {
    _init();
  }
  Worker.fromTask(IsolatedTask task) : this(isolateEntry: (sendPort) => task.initTask(sendPort));

  Future<void> _init() async {
    final receivePort = ReceivePort();
    receivePort.listen(handleMessage);
    _isolate = await Isolate.spawn(isolateEntry, receivePort.sendPort);
  }

  @mustCallSuper
  bool handleMessage(dynamic message) {
    if (message is SendPort) {
      sendPort = message;
      _isolateReady.complete();
      return true;
    }
    return false;
  }

  @mustCallSuper
  void dispose() {
    _isolate.kill();
  }
}
