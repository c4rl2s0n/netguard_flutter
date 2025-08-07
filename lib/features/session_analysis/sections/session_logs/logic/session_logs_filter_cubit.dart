import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/netguard.dart';

part 'session_logs_filter_cubit.freezed.dart';

class SessionLogsFilterCubit extends Cubit<SessionLogsFilterState> {
  SessionLogsFilterCubit(this._settingsCubit)
    : super(
        SessionLogsFilterState(
          showGrouped: _settingsCubit.state.logCompactView,
        ),
      );

  final SettingsCubit _settingsCubit;

  void setShowGrouped(bool showGrouped) {
    emit(state.copyWith(showGrouped: showGrouped));
    if (!showGrouped && state.sorting == LogSorting.volume) {
      setSorting(LogSorting.time);
    }
    _settingsCubit.setLogCompactView(showGrouped);
  }

  void setBlockedOnly(bool blockedOnly) {
    if (blockedOnly) emit(state.copyWith(allowedOnly: false));
    emit(state.copyWith(blockedOnly: blockedOnly));
  }

  void setAllowedOnly(bool allowedOnly) {
    if (allowedOnly) emit(state.copyWith(blockedOnly: false));
    emit(state.copyWith(allowedOnly: allowedOnly));
  }

  void setFilterApplications(List<Application?> filterApplications) {
    emit(state.copyWith(filterApplications: filterApplications));
  }

  void setSorting(LogSorting sorting) {
    emit(state.copyWith(sorting: sorting));
  }
}

@freezed
class SessionLogsFilterState with _$SessionLogsFilterState {
  const SessionLogsFilterState({
    this.showGrouped = false,
    this.blockedOnly = false,
    this.allowedOnly = false,
    this.filterApplications = const [],
    this.sorting = LogSorting.time,
  });

  @override
  final bool showGrouped;
  @override
  final bool blockedOnly;
  @override
  final bool allowedOnly;

  @override
  final List<Application?> filterApplications;
  @override
  final LogSorting sorting;

  bool filterAllowedBlocked<T>(T entry, bool Function(T) getAllowed) =>
      allowedOnly && getAllowed(entry) ||
      blockedOnly && !getAllowed(entry) ||
      !allowedOnly && !blockedOnly;
  Iterable<T> getLog<T>(SessionLogAnalysisState logs) {
    // return grouped
    if (showGrouped) {
      assert(T == TrafficLogGroup);
      Iterable<TrafficLogGroup> result = logs.groupedLogs
          .list(
            packageNames: filterApplications
                .map((a) => a?.packageName)
                .toList(),
          )
          .where((l) => filterAllowedBlocked(l, (e) => e.allowed));
      if (sorting == LogSorting.volume) {
        result = result.sorted((a, b) => b.count.compareTo(a.count));
      }
      return result as Iterable<T>;
    }

    // return single
    assert(T == TrafficLog);
    IList<TrafficLog> result = IList();
    if (filterApplications.empty) {
      result = logs.logs;
    } else {
      for (var application in filterApplications) {
        result = result.addAll(
          logs.logByApplication.get(application?.packageName) ?? [],
        );
      }
    }
    return result.where((l) => filterAllowedBlocked(l, (e) => e.allowed))
        as Iterable<T>;
  }
}
