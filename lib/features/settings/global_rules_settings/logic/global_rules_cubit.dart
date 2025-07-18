import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/features/settings/global_rules_settings/logic/rule_source_entry_cubit.dart';

part 'global_rules_cubit.freezed.dart';

class GlobalRulesCubit extends Cubit<GlobalRulesState> {
  GlobalRulesCubit() : super(GlobalRulesState(loading: true)) {
    _load();
  }

  @override
  Future<void> close() async {
    await super.close();
    for (RuleSourceEntryCubit source in state.sources) {
      await source.close();
    }
  }

  Future store() async {
    await globalRuleSourceRepository.updateAll(state.sourceEntities);
  }

  Future scanSources(LoadingDialogCubit loadingCubit) async {
    loadingCubit.setCanInterrupt(true);
    loadingCubit.setMessage("Scanning sources...");
    List<String> hosts = [];
    List<String> ips = [];

    for (int i = 0; i < state.sourceEntities.length; i++) {
      if (loadingCubit.state.stopped) {
        loadingCubit.finish();
        return;
      }
      loadingCubit.setProgress(i / state.sourceEntities.length);
      GlobalRuleSource source = state.sourceEntities[i];
      var result = switch (source.type) {
        SourceType.online => await _parseOnlineSource(source),
        SourceType.local => await _parseLocalSource(source),
      };
      if (result == null) continue;
      hosts.addAll(result.hosts);
      ips.addAll(result.ips);
    }
    loadingCubit.setProgress(null);
    loadingCubit.setMessage("Removing duplicates...");
    await sleep(Duration(microseconds: 1)); // push update to UI
    hosts = hosts.distinct;
    ips = ips.distinct;
    loadingCubit.setMessage(
      "Updating Database...\nFound:\n- ${hosts.length} domains\n- ${ips.length} IPs",
    );
    loadingCubit.setCanInterrupt(false);
    await blacklistRepository.clearGeneric();
    // TODO: BulkInsert!! Move to isolate!! (?) maybe the whole process here should be moved to isolate, but how to show Progress then?
    // TODO: make LoadingDialog Isolate-ready and do this process here in isolate...
    // Todo: it is okayif it takes a while, but it is not okay, if it blocks the whole UI
    await blacklistRepository.insertAll([
      ...hosts.map((s) => BlacklistTableCompanion.insert(target: s, type: BlacklistType.host)),
      ...ips.map((s) => BlacklistTableCompanion.insert(target: s, type: BlacklistType.ip)),
    ]);

    settingsCubit.setLastBlacklistUpdate();
    loadingCubit.finish();
  }

  Future<HostsParsingResult?> _parseOnlineSource(
    GlobalRuleSource source,
  ) async {
    String? hostsfile = await WebTools.getRawWebsite(source.source);
    if (hostsfile.empty) return null;
    return ParsingTools.parseHosts(hostsfile!);
  }

  Future<HostsParsingResult?> _parseLocalSource(GlobalRuleSource source) async {
    return null;
    // TODO: Read hostsfile from local file!
    String? hostsfile = await WebTools.getRawWebsite(source.source);
    if (hostsfile.empty) return null;
    return ParsingTools.parseHosts(hostsfile!);
  }

  Future removeSource(RuleSourceEntryCubit source) async {
    var sources = state.sources.toList();
    if (sources.remove(source)) {
      await source.close();
      emit(state.copyWith(sources: sources));
    }
  }

  Future _load() async {
    emit(
      state.copyWith(
        loading: false,
        sources: (await globalRuleSourceRepository.getAll())
            .map((s) => RuleSourceEntryCubit(s))
            .toList(),
      ),
    );
  }

  void createSource(SourceType type) {
    emit(
      state.copyWith(
        sources: [
          ...state.sources,
          RuleSourceEntryCubit(GlobalRuleSource(type: type)),
        ],
      ),
    );
  }
}

@freezed
class GlobalRulesState with _$GlobalRulesState {
  GlobalRulesState({required this.loading, this.sources = const []});

  @override
  final bool loading;
  @override
  final List<RuleSourceEntryCubit> sources;

  List<RuleSourceEntryCubit> get onlineSources =>
      sources.where((s) => s.state.type == SourceType.online).toList();
  List<RuleSourceEntryCubit> get localSources =>
      sources.where((s) => s.state.type == SourceType.local).toList();

  List<GlobalRuleSource> get sourceEntities =>
      sources.map((s) => s.state.entity).toList();
}
