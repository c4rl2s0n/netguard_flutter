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
    for (var rule in state.rules) {
      await rule.close();
    }
    return super.close();
  }

  Future createRule() async {
    emit(
      state.copyWith(
        rules: [
          RuleCubit(Rule(id: IdTools.generateUuid(), type: RuleType.blacklist)),
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

  Future store() async {
    await applicationSettingsRepository.insert(state.setting);
    await rulesRepository.insertAll(
      state.rules.map((r) => r.state.rule).toList(),
    );
  }

  void toggleFilter() {
    emit(state.copyWith(filter: !state.filter));
    applicationSettingsRepository.insert(state.setting);
  }

  void setFilter(bool filter) {
    emit(state.copyWith(filter: filter));
    applicationSettingsRepository.insert(state.setting);
  }

  void setBlockAll(bool block) {
    emit(state.copyWith(blockAll: block));
    applicationSettingsRepository.insert(state.setting);
  }
}

@freezed
class ApplicationEntryState with _$ApplicationEntryState {
  const ApplicationEntryState({
    required this.app,
    required this.filter,
    required this.blockAll,
    this.rules = const [],
  });
  ApplicationEntryState.fromModels(Application app, ApplicationSetting setting)
    : this(
        app: app,
        filter: setting.filter,
        blockAll: setting.blockAll,
        rules: app.rules.map((r) => RuleCubit(r)).toList(),
      );
  @override
  final Application app;
  @override
  final bool filter;
  @override
  final bool blockAll;

  @override
  final List<RuleCubit> rules;

  ApplicationSetting get setting => ApplicationSetting(
    packageName: app.packageName,
    filter: filter,
    blockAll: blockAll,
  );
}
