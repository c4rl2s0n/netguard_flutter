import 'package:drift/isolate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/features/settings/global_rules_settings/logic/scan_sources_task.dart';

part 'global_rules_cubit.freezed.dart';

class GlobalRulesCubit extends Cubit<GlobalRulesState> {
  GlobalRulesCubit() : super(GlobalRulesState(loading: true)) {
    _load();
  }

  Future store() async {
    await globalRuleSourceRepository.updateAll(state.sources);
  }

  Future scanSources(LoadingCubit loadingCubit) async {
    await ScanSourcesTask().execute(
      loadingCubit,
      ScanSourcesTaskArgument(await databaseConnection, state.sources),
    );
    settingsCubit.setLastHostlistUpdate();
  }

  Future removeSource(GlobalRuleSource source) async {
    var sources = state.sources.toList();
    if (sources.remove(source)) {
      emit(state.copyWith(sources: sources));
    }
  }

  Future _load() async {
    emit(
      state.copyWith(
        loading: false,
        sources: await globalRuleSourceRepository.getAll(),
      ),
    );
  }

  void createSource(SourceType type) {
    emit(
      state.copyWith(
        sources: [
          ...state.sources,
          GlobalRuleSource(type: type),
        ],
      ),
    );
  }

  void addSources(List<GlobalRuleSource> sources) {
    emit(state.copyWith(sources: [...state.sources, ...sources]));
  }
}

@freezed
class GlobalRulesState with _$GlobalRulesState {
  GlobalRulesState({required this.loading, this.sources = const []});

  @override
  final bool loading;
  @override
  final List<GlobalRuleSource> sources;

  List<GlobalRuleSource> get onlineSources =>
      sources.where((s) => s.type == SourceType.online).toList();
  List<GlobalRuleSource> get localSources =>
      sources.where((s) => s.type == SourceType.local).toList();
}
