import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/netguard.dart';

import 'hosts_edit_entry_cubit.dart';

part 'hosts_edit_dialog_cubit.freezed.dart';

class HostsEditDialogCubit extends Cubit<HostsEditDialogState> {
  HostsEditDialogCubit(Rule rule)
    : super(HostsEditDialogState(loading: true, rule: rule)) {
    _load();
  }

  @override
  Future<void> close() async {
    for (var entry in state.entries) {
      await entry.close();
    }
    return await super.close();
  }

  void setSearch(String search) {
    emit(state.copyWith(search: search.empty ? null : search));
  }

  Future _load() async {
    Set<String> hosts = state.rule.hosts.keys.toSet();
    Set<String> ips = state.rule.ips.keys.toSet();
    hosts.addAll(
      (await trafficStatisticsRepository.getHostsForPackage(
        state.rule.packageName,
      )).sorted(compareHostnames),
    );
    ips.addAll(
      (await trafficStatisticsRepository.getIPsForPackage(
        state.rule.packageName,
      )).sorted(compareIPs),
    );

    emit(
      state.copyWith(
        loading: false,
        entries: [
          ...hosts.map(
            (h) => HostsEditEntryCubit(
              HostEntry(target: h, type: HostType.host),
              state.rule.hosts.containsKey(h),
            ),
          ),
          ...ips.map(
            (h) => HostsEditEntryCubit(
              HostEntry(target: h, type: HostType.ip),
              state.rule.hosts.containsKey(h),
            ),
          ),
        ],
      ),
    );
  }
}

@freezed
class HostsEditDialogState with _$HostsEditDialogState {
  const HostsEditDialogState({
    required this.loading,
    required this.rule,
    this.entries = const [],
    this.search,
  });

  @override
  final bool loading;
  @override
  final Rule rule;
  @override
  final List<HostsEditEntryCubit> entries;
  @override
  final String? search;

  Iterable<HostsEditEntryCubit> get visibleEntries => entries.where(
    (e) => search.empty || e.state.entry.target.contains(search!),
  );
}
