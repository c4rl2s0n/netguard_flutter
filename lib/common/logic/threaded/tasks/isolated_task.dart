import 'dart:isolate';

abstract class IsolatedTask {
  late SendPort sendPort;
  bool isInitialized = false;
  bool canAbort = false;

  IsolatedTask();

  void initTask(dynamic message) {
    ReceivePort receivePort = ReceivePort();
    receivePort.listen(isolatedTaskErrorLayer);

    if (message is SendPort) {
      sendPort = message;
      sendPort.send(receivePort.sendPort);
      isInitialized = true;
      return;
    }
  }

  void isolatedTaskErrorLayer(dynamic message);

  Future isolatedTask(dynamic message);
}

