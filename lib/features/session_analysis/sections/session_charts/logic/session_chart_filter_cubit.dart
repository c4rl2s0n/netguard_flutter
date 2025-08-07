import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/netguard.dart';

part 'session_chart_filter_cubit.freezed.dart';

class SessionChartFilterCubit extends Cubit<SessionChartFilterState> {
  SessionChartFilterCubit(this._settingsCubit)
    : super(
        SessionChartFilterState.fromSettings(_settingsCubit.state.settings),
      );

  final SettingsCubit _settingsCubit;

  void setFilterApplications(List<Application?> filterApplications) {
    emit(state.copyWith(filterApplications: filterApplications));
  }

  void setSorting(LogSorting sorting) {
    emit(state.copyWith(sorting: sorting));
    _settingsCubit.setAnalysisChartSorting(sorting);
  }

  void setChartType(ChartType chartType) {
    emit(state.copyWith(chartType: chartType));
    _settingsCubit.setAnalysisChartType(chartType);
  }

  void setSingleBar(bool singleBar) {
    emit(state.copyWith(singleBar: singleBar));
    _settingsCubit.setAnalysisChartSingleBar(singleBar);
  }

  void setGroupType(GroupType groupType) {
    emit(state.copyWith(groupType: groupType));
    _settingsCubit.setAnalysisChartGroupType(groupType);
  }
}

@freezed
class SessionChartFilterState with _$SessionChartFilterState {
  const SessionChartFilterState._({
    this.filterApplications = const [],
    this.sorting = LogSorting.time,
    this.chartType = ChartType.pie,
    this.singleBar = true,
    this.groupType = GroupType.application,
  });
  factory SessionChartFilterState.fromSettings(Settings settings) =>
      SessionChartFilterState._(
        sorting: settings.chartSettingsSorting,
        chartType: settings.chartSettingsChartType,
        singleBar: settings.chartSettingsSingleBar,
        groupType: settings.chartSettingsGroupType,
      );

  @override
  final List<Application?> filterApplications;
  @override
  final LogSorting sorting;
  @override
  final bool singleBar;
  @override
  final ChartType chartType;
  @override
  final GroupType groupType;
}
