import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:netguard/common/logic/tools/logging_tools.dart';

class SnackBarService {
  final GlobalKey<ScaffoldMessengerState> _messengerKey;

  SnackBarService(this._messengerKey);

  void show(SnackBar message) {
    final messenger = _messengerKey.currentState;
    if (messenger != null) {
      messenger.showSnackBar(message);
    } else {
      LoggingTools.onRecord(
        LogRecord(
          Level.CONFIG,
          "ScaffoldMessenger is not ready yet.",
          "Musicious.SnackBarService",
        ),
      );
    }
  }
}
