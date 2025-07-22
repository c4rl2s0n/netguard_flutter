import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drift/isolate.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

class RuleImportTaskArgument {
  const RuleImportTaskArgument(this.dbConnection, this.file);
  final DriftIsolate dbConnection;
  final String file;
}

class RuleImportTask extends ProgressTask {
  RuleImportTask();

  late AppDatabase db;

  @override
  Future isolatedTask(message) async {
    if (message is! RuleImportTaskArgument) {
      return;
    }

    db = AppDatabase(await message.dbConnection.connect());

    await parse(message.file);
    updateProgress((lc) => lc.finish());
  }

  Future parse(String filepath) async {
    updateProgress((lc) => lc.setCanInterrupt(true));
    updateProgress((lc) => lc.setMessage("Scanning sources..."));

    File file = File(filepath);
    if(!await file.exists()){
      // TODO: check if this works!
      updateProgress((lc) => lc.setError("File does not exist..."));
      return;
    }
    String fileContent = await file.readAsString();

    List<Rule> rules = ParsingTools.parseRules(fileContent);

    if(rules.isEmpty){
      SnackBarFactory.showNegativeSnackBar("No rules found in file...");
      return [];
    }

    updateProgress((lc) => lc.setProgress(null));
    updateProgress(
          (lc) => lc.setMessage(
        "Updating Database...\nFound:\n- ${rules.length} rules",
      ),
    );
    updateProgress((lc) => lc.setCanInterrupt(false));
    RulesRepository rulesRepository = RulesRepository(db);

    int chunkCount = 0;
    int chunkSize = 5000;
    int totalChunks = (rules.length / chunkSize).ceil();
    for(final chunk in rules.slices(chunkSize)) {
      updateProgress((lc) => lc.setProgress(chunkCount / totalChunks));
      await rulesRepository.insertAll(chunk);
      chunkCount++;
    }
    updateProgress((lc) => lc.setProgress(null));
  }
}
