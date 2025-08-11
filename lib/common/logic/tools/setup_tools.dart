import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'logging_tools.dart';

class SetupTools {
  static Future<AppFilepaths> getFilepaths() async {
    // initialize filepaths and database
    // NOTE: do not change these, as the filenames are also hardcoded in JAVA/Native side
    Directory dir = await getApplicationDocumentsDirectory();

    AppFilepaths filepaths = AppFilepaths(
      applicationDocumentsDirectory: path.join(dir.path, 'netguard'),
      databaseFilename: "netguard.db",
    );
    await _prepareStorage(filepaths.applicationDocumentsDirectory);
    return filepaths;
  }

  static Future _prepareStorage(String applicationDirectory) async {
    Directory dir = Directory(applicationDirectory);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }

  static void setupLogging(String applicationDocumentsDirectory) {
    // Error handling
    LoggingTools.setup(applicationDocumentsDirectory);
    FlutterError.onError = LoggingTools.onError;
  }
}

class AppFilepaths {
  const AppFilepaths({
    required this.applicationDocumentsDirectory,
    required this.databaseFilename,
  });
  final String applicationDocumentsDirectory;
  final String databaseFilename;
}
