import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

part 'rule_cubit.freezed.dart';

class RuleCubit extends Cubit<RuleState> {
  RuleCubit(Rule rule) : super(RuleState.fromRule(rule));

  Future setName(String name) async {
    emit(state.copyWith(name: name));
    await rulesRepository.updateName(state.id, name);
  }

  Future setDescription(String description) async {
    emit(state.copyWith(description: description));
    await rulesRepository.updateDescription(state.id, description);
  }

  Future setType(RuleType type) async {
    emit(state.copyWith(type: type));
    await rulesRepository.updateType(state.id, type);
  }

  Future setWhitelistExclusive(bool whitelistExclusive) async {
    emit(state.copyWith(whitelistExclusive: whitelistExclusive));
    await rulesRepository.updateWhitelistExclusive(state.id, whitelistExclusive);
  }

  Future setActive(bool active) async {
    emit(state.copyWith(active: active));
    await rulesRepository.updateActive(state.id, active);
  }

  Future setHosts(Iterable<HostEntry> entries) async {
    List<HostEntry> hosts = entries.toList();
    emit(
      state.copyWith(
        hosts: hosts
            .where((e) => e.type == HostType.host)
            .map((e) => e.target)
            .toList(),
        ips: hosts
            .where((e) => e.type == HostType.ip)
            .map((e) => e.target)
            .toList(),
      ),
    );
    await rulesRepository.updateHosts(state.id, hosts);
  }
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
    this.shouldBlockQuic = false,
    this.whitelistExclusive = true,
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
        shouldBlockQuic: rule.shouldBlockQuic,
        whitelistExclusive: rule.whitelistExclusive,
        hosts: rule.hosts.keys.toList(),
        ips: rule.ips.keys.toList(),
      );

  @override
  String id;
  @override
  String? name;
  @override
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
  bool shouldBlockQuic;
  @override
  bool whitelistExclusive;
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
    shouldBlockQuic: shouldBlockQuic,
    whitelistExclusive: whitelistExclusive,
    hosts: hosts.boolMap((_) => true),
    ips: ips.boolMap((_) => true),
  );
}
