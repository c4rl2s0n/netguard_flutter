import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';
import 'package:netguard/features/applications_view/application_view/logic/rule_cubit.dart';

part 'application_entry_cubit.freezed.dart';

class ApplicationEntryCubit extends Cubit<ApplicationEntryState> {
  ApplicationEntryCubit(Application application, ApplicationSetting entry)
    : super(
        ApplicationEntryState.fromModels(
          application,
          entry,
          application.rules.map((r) => RuleCubit(r)).toList(),
        ),
      ) {
    for (var rule in state.rules) {
      ruleListener[rule.state.id] = rule.stream.listen(onRuleChanged);
    }
  }

  Map<String, StreamSubscription> ruleListener = {};

  @override
  Future<void> close() async {
    state.app.rules = state.rules.map((r) => r.state.rule).toList();
    for (var rule in state.rules) {
      await rule.close();
    }
    for (var listener in ruleListener.values) {
      await listener.cancel();
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
    var cubit = RuleCubit(rule);
    ruleListener[rule.id] = cubit.stream.listen(onRuleChanged);
    emit(
      // TODO: check what else to init
      state.copyWith(
        rules: [cubit, ...state.rules],
        ruleStates: [cubit.state, ...state.ruleStates],
      ),
    );
  }

  Future deleteRule(RuleCubit r) async {
    await ruleListener.remove(r.state.id)?.cancel();
    await r.close();
    var rules = state.rules.toList();
    if (rules.remove(r)) {
      emit(
        state.copyWith(
          rules: rules,
          ruleStates: rules.map((r) => r.state).toList(),
        ),
      );
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

  void onRuleChanged([RuleState? _]) {
    emit(state.copyWith(ruleStates: state.rules.map((r) => r.state).toList()));
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
    this.ruleStates = const [],
  });
  ApplicationEntryState.fromModels(
    Application app,
    ApplicationSetting setting,
    List<RuleCubit> rules,
  ) : this(
        app: app,
        filter: setting.filter,
        blockAll: setting.blockAll,
        blockQuic: setting.blockQuic,
        rules: rules,
        ruleStates: rules.map((r) => r.state).toList(),
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
  @override
  final List<RuleState> ruleStates;

  bool get differentBlockQuicRequirements {
    return ruleStates
            .where((r) => r.active)
            .map((r) => r.shouldBlockQuic)
            .toSet()
            .length >
        1;
  }

  bool get differentRuleTypes {
    return ruleStates.where((r) => r.active).map((r) => r.type).toSet().length >
        1;
  }

  bool get hasExclusiveWhitelist {
    return ruleStates.any(
      (r) => r.active && r.type == RuleType.whitelist && r.whitelistExclusive,
    );
  }

  bool get differentWhitelistTypes {
    return ruleStates
            .where((r) => r.active && r.type == RuleType.whitelist)
            .map((r) => r.whitelistExclusive)
            .toSet()
            .length >
        1;
  }

  bool get shouldBlockQuic {
    return ruleStates.where((r) => r.active).any((r) => r.shouldBlockQuic);
  }

  ApplicationSetting get setting => ApplicationSetting(
    packageName: app.packageName,
    filter: filter,
    blockAll: blockAll,
    blockQuic: blockQuic,
  );
}
