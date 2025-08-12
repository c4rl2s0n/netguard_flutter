import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drift/isolate.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

class ScanSourcesTaskArgument {
  const ScanSourcesTaskArgument(this.dbConnection, this.sources);
  final DriftIsolate dbConnection;
  final List<GlobalRuleSource> sources;
}

class ScanSourcesTask extends ProgressTask {
  ScanSourcesTask();

  late AppDatabase db;

  @override
  Future isolatedTask(message) async {
    if (message is! ScanSourcesTaskArgument) {
      return;
    }

    db = AppDatabase(await message.dbConnection.connect());

    await scanSources(message.sources);
    updateProgress((lc) => lc.finish());
  }

  Future scanSources(List<GlobalRuleSource> sources) async {
    updateProgress((lc) => lc.setCanInterrupt(true));
    updateProgress((lc) => lc.setMessage("Scanning sources..."));
    HostsParsingResult result = HostsParsingResult.empty();
    HostsRepository blacklistRepository = HostsRepository(db);
    GlobalRuleSourceRepository globalRuleSourceRepository = GlobalRuleSourceRepository(db);

    for (int i = 0; i < sources.length; i++) {
      if (loadingState.stopped) {
        return;
      }
      updateProgress((lc) => lc.setProgress(i / sources.length));
      GlobalRuleSource source = sources[i];
      var _ = switch (source.type) {
        SourceType.online => await _parseOnlineSource(source, result: result),
        SourceType.local => await _parseLocalSource(source, result: result),
      };
    }

    // update hashes

    updateProgress((lc) => lc.setProgress(null));
    updateProgress(
          (lc) => lc.setMessage(
        "Updating Database...\nFound ${result.scannedSources.length} new/changed sources\nUpdate hashes",
      ),
    );
    await globalRuleSourceRepository.updateAll(sources);

    updateProgress((lc) => lc.setProgress(null));
    updateProgress(
      (lc) => lc.setMessage(
        "Updating Database...\nFound:\n- ${result.hosts.length.longNum} domains\n- ${result.ips.length.longNum} IPs",
      ),
    );
    updateProgress((lc) => lc.setCanInterrupt(false));
    //await blacklistRepository.clearGeneric();

    List<HostEntry> entries = [...result.hosts.map(
          (s) =>
          HostEntry(target: s, type: HostType.host),
    ),
      ...result.ips.map(
            (s) => HostEntry(target: s, type: HostType.ip),
      ),];
    int chunkCount = 0;
    int chunkSize = 5000;
    int totalChunks = (entries.length / chunkSize).ceil();
    for(final chunk in entries.slices(chunkSize)) {
      updateProgress((lc) => lc.setProgress(chunkCount / totalChunks));
      await blacklistRepository.insertAll(chunk);
      chunkCount++;
    }
    updateProgress((lc) => lc.setProgress(null));
  }

  Future<HostsParsingResult?> _parseOnlineSource(
    GlobalRuleSource source, {
    HostsParsingResult? result,
  }) async {
    String? hostsfile = await WebTools.getRawWebsite(source.source);
    if (hostsfile.empty) return result;
    String contentHash = IdTools.generateMd5(hostsfile!);
    if(contentHash == source.contentHash) return result;
    source.contentHash = contentHash;
    result = ParsingTools.parseHosts(hostsfile, result: result);
    result.scannedSources.add(source);
    return result;
  }

  Future<HostsParsingResult?> _parseLocalSource(
    GlobalRuleSource source, {
    HostsParsingResult? result,
  }) async {
    File file = File(source.source);
    if (!await file.exists()){
      return result;
    }
    String hostsfile = await file.readAsString();
    if (hostsfile.empty) return result;
    String contentHash = IdTools.generateMd5(hostsfile);
    if(contentHash == source.contentHash) return result;
    source.contentHash = contentHash;
    result = ParsingTools.parseHosts(hostsfile, result: result);
    result.scannedSources.add(source);
    return result;
  }
}
