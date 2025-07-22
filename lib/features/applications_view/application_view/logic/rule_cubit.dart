import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

part 'rule_cubit.freezed.dart';

class RuleCubit extends Cubit<RuleState> {
  RuleCubit(Rule rule) : super(RuleState.fromRule(rule));

  void setName(String name) => emit(state.copyWith(name: name));
  void setDescription(String description) => emit(state.copyWith(description: description));
  void setType(RuleType type) => emit(state.copyWith(type: type));
  void setBlockQuic(bool block) => emit(state.copyWith(blockQuic: block));
  void setActive(bool active) => emit(state.copyWith(active: active));
}

@freezed
class RuleState with _$RuleState {
  RuleState({
    required this.id,
    this.packageName,
    this.name,
    this.description,
    this.targetVersion,
    this.type = RuleType.blacklist,
    this.active = true,
    this.blockQuic = false,
    this.hosts = const [],
    this.ips = const [],
  });
  RuleState.fromRule(Rule rule)
    : this(
        id: rule.id,
        packageName: rule.packageName,
        name: rule.name,
        description: rule.description,
        targetVersion: rule.targetVersion,
        type: rule.type,
        active: rule.active,
        blockQuic: rule.blockQuic,
        hosts: rule.hosts.keys.toList(),
        ips: rule.ips.keys.toList(),
      );

  String id;
  @override
  String? name;
  String? packageName;
  @override
  String? description;
  @override
  String? targetVersion;
  @override
  RuleType type;
  @override
  bool active;
  @override
  bool blockQuic;
  @override
  List<String> hosts;
  @override
  List<String> ips;

  Rule get rule => Rule(
    id: id,
    packageName: packageName,
    name: name,
    description: description,
    targetVersion: targetVersion,
    type: type,
    active: active,
    blockQuic: blockQuic,
    hosts: hosts.boolMap((_) => true),
    ips: ips.boolMap((_) => true),
  );
}
