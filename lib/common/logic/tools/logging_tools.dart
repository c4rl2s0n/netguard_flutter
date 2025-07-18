import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';

/// Bundles functionality for simple logging.
///
/// Call `LoggingTools.setup(directory, {logfile, logLevel})` to enable logging.
class LoggingTools {
  static String logPath = "";

  static void setup(
    String documentsPath, {
    String logfile = "logs.json",
    Level logLevel = Level.ALL,
  }) {
    logPath = join(documentsPath, logfile);
    Logger.root.level = logLevel;
    Logger.root.onRecord.listen(onRecord);

    FlutterError.onError = onError;
  }

  static void onRecord(LogRecord record) async {
    File logfile = File(logPath);
    if (!await logfile.exists()) {
      await logfile.create(recursive: true);
    }
    await logfile.writeAsString(
      "${logToJson(record)}\n",
      mode: FileMode.append,
    );
    if (kDebugMode) {
      print(record.toString());
    }
  }

  static void onError(FlutterErrorDetails details) async {
    File logfile = File(logPath);
    if (!await logfile.exists()) {
      await logfile.create(recursive: true);
    }
    await logfile.writeAsString(
      "${errorToJson(details)}\n",
      mode: FileMode.append,
    );
    FlutterError.presentError(details);
  }

  static String logToJson(LogRecord record) {
    Map<String, dynamic> errorMap = {
      'timestamp': record.time.toString(),
      'level': record.level.name,
      'message': record.message,
      'error': record.error?.toString(),
      'stackTrace': record.stackTrace?.toString(),
      'zone': record.zone?.toString(),
    };
    return jsonEncode(errorMap);
  }

  static String errorToJson(FlutterErrorDetails details) {
    Map<String, dynamic> errorMap = {
      'timestamp': DateTime.now().toString(),
      'exception': details.exceptionAsString(),
      'stackTrace': details.stack.toString(),
      'context': details.context?.toJsonMap(
        const DiagnosticsSerializationDelegate(
          subtreeDepth: 5,
          includeProperties: true,
        ),
      ),
      'library': details.library.toString(),
    };
    return jsonEncode(errorMap);
  }

  static int javaLogLevel(Level level) {
    return switch (level) {
      Level.ALL => _JavaLogLevel.VERBOSE,
      Level.FINEST => _JavaLogLevel.VERBOSE,
      Level.FINER => _JavaLogLevel.VERBOSE,
      Level.FINE => _JavaLogLevel.DEBUG,
      Level.CONFIG => _JavaLogLevel.DEBUG,
      Level.INFO => _JavaLogLevel.INFO,
      Level.WARNING => _JavaLogLevel.WARN,
      Level.SEVERE => _JavaLogLevel.ERROR,
      Level.SHOUT => _JavaLogLevel.ERROR,
      Level.OFF => _JavaLogLevel.ASSERT,
      _ => _JavaLogLevel.WARN,
    };
  }
}

class _JavaLogLevel {
  static const int VERBOSE = 2;
  static const int DEBUG = 3;
  static const int INFO = 4;
  static const int WARN = 5;
  static const int ERROR = 6;
  static const int ASSERT = 7;
}
