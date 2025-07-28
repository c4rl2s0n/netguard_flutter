import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/models/traffic_log_group.dart';

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
    if(!showGrouped) setSorting(LogSorting.time);
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

  void setFilterApplication(String filterApplication) {
    emit(state.copyWith(filterApplication: filterApplication));
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
    this.filterApplication = FilterStrings.all,
    this.sorting = LogSorting.time,
  });

  final bool showGrouped;
  final bool blockedOnly;
  final bool allowedOnly;

  final String filterApplication;
  final LogSorting sorting;

  bool filterAllowedBlocked<T>(T entry, bool Function(T) getAllowed) =>
      allowedOnly && getAllowed(entry) ||
      blockedOnly && !getAllowed(entry) ||
      !allowedOnly && !blockedOnly;
  Iterable<T> getLog<T>(SessionLogsState logs) {
    // return grouped
    if (showGrouped) {
      assert(T == TrafficLogGroup);
      Iterable<TrafficLogGroup> result = logs.sessionTrafficLogGroups
          .list(packageName: filterApplication)
          .where((l) => filterAllowedBlocked(l, (e) => e.allowed));
      if (sorting == LogSorting.packetCount) {
        result = result.sorted((a, b) => b.count.compareTo(a.count));
      }
      return result as Iterable<T>;
    }

    // return single
    assert(T == TrafficLog);
    IList<TrafficLog> result;
    if (filterApplication != FilterStrings.all) {
      if(filterApplication == FilterStrings.unknown){
        result = logs.sessionTrafficLogByApp.get(null) ?? IList();
      } else {
        result = logs.sessionTrafficLogByApp.get(filterApplication) ?? IList();
      }
    } else {
      result = logs.sessionTrafficLog;
    }
    return result.where(
      (l) => filterAllowedBlocked(l, (e) => e.allowed),
    ) as Iterable<T>;
  }
}

class FilterStrings{
  static const String all = "All";
  static const String unknown = "Unknown";
}

enum LogSorting { time, packetCount }
