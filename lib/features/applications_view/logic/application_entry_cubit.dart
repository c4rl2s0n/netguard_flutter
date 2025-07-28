import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/features/applications_view/application_view/logic/rule_cubit.dart';

part 'application_entry_cubit.freezed.dart';

class ApplicationEntryCubit extends Cubit<ApplicationEntryState> {
  ApplicationEntryCubit(Application application, ApplicationSetting entry)
    : super(ApplicationEntryState.fromModels(application, entry));

  @override
  Future<void> close() async {
    state.app.rules = state.rules.map((r) => r.state.rule).toList();
    for (var rule in state.rules) {
      await rule.close();
    }
    return super.close();
  }

  Future createRule() async {
    Rule rule = Rule(
      id: IdTools.generateUuid(),
      name: "New Rule",
      packageName: state.setting.packageName,
      type: RuleType.blacklist,
    );
    await rulesRepository.insert(rule);
    emit(
      state.copyWith(
        rules: [
          // TODO: check what else to init
          RuleCubit(rule),
          ...state.rules,
        ],
      ),
    );
  }

  Future deleteRule(RuleCubit r) async {
    await r.close();
    var rules = state.rules.toList();
    if (rules.remove(r)) {
      emit(state.copyWith(rules: rules));
      await rulesRepository.delete(r.state.id);
    }
  }

  void setFilter(bool filter) {
    emit(state.copyWith(filter: filter));
    state.app.setting?.filter = filter;
    applicationSettingsRepository.insert(state.setting);
  }

  void setBlockAll(bool block) {
    emit(state.copyWith(blockAll: block));
    state.app.setting?.blockAll = block;
    applicationSettingsRepository.insert(state.setting);
  }

  void setBlockQuic(bool blockQuic) {
    emit(state.copyWith(blockQuic: blockQuic));
    state.app.setting?.blockQuic = blockQuic;
    applicationSettingsRepository.insert(state.setting);
  }
}

@freezed
class ApplicationEntryState with _$ApplicationEntryState {
  const ApplicationEntryState({
    required this.app,
    required this.filter,
    required this.blockAll,
    required this.blockQuic,
    this.rules = const [],
  });
  ApplicationEntryState.fromModels(Application app, ApplicationSetting setting)
    : this(
        app: app,
        filter: setting.filter,
        blockAll: setting.blockAll,
        blockQuic: setting.blockQuic,
        rules: app.rules.map((r) => RuleCubit(r)).toList(),
      );
  @override
  final Application app;
  @override
  final bool filter;
  @override
  final bool blockAll;
  @override
  final bool blockQuic;

  @override
  final List<RuleCubit> rules;

  ApplicationSetting get setting => ApplicationSetting(
    packageName: app.packageName,
    filter: filter,
    blockAll: blockAll,
    blockQuic: blockQuic,
  );
}
