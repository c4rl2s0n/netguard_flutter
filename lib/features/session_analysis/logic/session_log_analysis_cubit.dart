import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

import '../session_analysis.dart';

part 'session_log_analysis_cubit.freezed.dart';

class SessionLogAnalysisCubit extends Cubit<SessionLogAnalysisState> {
  SessionLogAnalysisCubit(this._settingsCubit)
    : super(SessionLogAnalysisState.initial(_settingsCubit));

  final SettingsCubit _settingsCubit;

  bool get hasLogs => state.hasLogs;

  @override
  Future close() async {
    await _closeCubits();
    return super.close();
  }

  Future _closeCubits() async {
    await state.chartFilterCubit.close();
  }

  void setView(AnalysisView view) {
    emit(state.copyWith(view: view));
    if(view == AnalysisView.chart){
      reSort();
    }
  }

  void setVolumeType(VolumeType volumeType) {
    emit(state.copyWith(volumeType: volumeType));
    _settingsCubit.setAnalysisVolumeType(volumeType);
  }

  void clear() {
    return emit(state.clear());
  }

  void insert(TrafficLog log, Map<String, Application> possibleApplications) {
    bool isNew =
        !state.analysisByApplication.containsKey(log.packageName) ||
        !state.analysisByDestination.containsKey(log.destination);
    state.groupedLogs.insert(log);

    IMap<String?, IList<TrafficLog>> logByApp = state.logByApplication;
    IList<TrafficLog> appLog =
        logByApp.get(log.packageName) ?? IList<TrafficLog>();
    IMap<String, IList<TrafficLog>> logByDest = state.logByDestination;
    IList<TrafficLog> destLog =
        logByDest.get(log.destination) ?? IList<TrafficLog>();

    SessionLogAnalysisState newState = state.copyWith(
      logs: state.logs.add(log),
      logByApplication: logByApp.add(log.packageName, appLog.add(log)),
      logByDestination: logByDest.add(log.destination, destLog.add(log)),
      analysisByApplication: _insertByApplication(log, possibleApplications),
      analysisByDestination: _insertByDestination(log),
    );

    // only re-sort/filter every second or when a new entry was added
    if (isNew) {
      newState = _applySortAndFilter(state: newState);
    }
    emit(newState);
  }

  IMap<String?, TrafficLogByApplication> _insertByApplication(
    TrafficLog log,
    Map<String, Application> possibleApplications,
  ) {
    // get the correct group for the package and insert the log
    String? package = log.packageName;
    if (!possibleApplications.containsKey(package)) package = null;
    TrafficLogByApplication analysis =
        (state.analysisByApplication[package] ??
                TrafficLogByApplication(
                  application: possibleApplications[package],
                ))
            .add(log);
    return state.analysisByApplication.add(package, analysis);
  }

  IMap<String, TrafficLogByDestination> _insertByDestination(TrafficLog log) {
    TrafficLogByDestination analysis =
        (state.analysisByDestination[log.destination] ??
                TrafficLogByDestination(destination: log.destination))
            .add(log);
    return state.analysisByDestination.add(log.destination, analysis);
  }

  SessionLogAnalysisState _applySortAndFilter({
    SessionLogAnalysisState? state,
  }) {
    state ??= this.state;
    var compare = _compare();

    List<TrafficLogByApplication> analysisByApp = state
        .analysisByApplication
        .values
        .where(
          (a) =>
              state!.chartFilter.filterApplications.empty ||
              state.chartFilter.filterApplications.contains(a.application),
        )
        .toList();
    List<TrafficLogByDestination> analysisByDestination = state
        .analysisByDestination
        .values
        .toList();

    if (compare != null) {
      analysisByApp.sort(compare);
      analysisByDestination.sort(compare);
    }
    return state.copyWith(
      applicationsSortedFiltered: analysisByApp
          .map((a) => a.application?.packageName)
          .toList()
          .lock,
      destinationsSortedFiltered: analysisByDestination
          .map((a) => a.destination)
          .toList()
          .lock,
      lastSort: DateTime.timestamp(),
    );
  }

  int Function(TrafficLogAggregation, TrafficLogAggregation)? _compare() =>
      ComparisonTools.getSortingFunction<TrafficLogAggregation>(
        state.chartFilter.sorting,
        getVolume: switch (state.volumeType) {
          VolumeType.count => (x) => x.count.toDouble(),
          VolumeType.bytes => (x) => x.size.toDouble(),
        },
        getVolumeBlocked: switch (state.volumeType) {
          VolumeType.count => (x) => x.countBlocked.toDouble(),
          VolumeType.bytes => (x) => x.sizeBlocked.toDouble(),
        },
        getName: (x) => x.label,
        getTime: (x) => x.latest,
      );

  void maybeSort() {
    if (state.lastSort == null ||
        DateTime.timestamp().difference(state.lastSort!).inMilliseconds >
            1000) {
      reSort();
    }
  }

  void reSort() {
    emit(_applySortAndFilter());
  }
}

@freezed
class SessionLogAnalysisState with _$SessionLogAnalysisState {
  const SessionLogAnalysisState({
    this.view = AnalysisView.logs,
    required this.chartFilterCubit,
    this.lastSort,
    required this.logs,
    required this.groupedLogs,
    required this.logByApplication,
    required this.logByDestination,
    required this.analysisByApplication,
    required this.analysisByDestination,
    required this.applicationsSortedFiltered,
    required this.destinationsSortedFiltered,
    required this.volumeType,
  });

  factory SessionLogAnalysisState.initial(SettingsCubit settings) =>
      SessionLogAnalysisState(
        logs: const IListConst([]),
        chartFilterCubit: SessionChartFilterCubit(settings),
        groupedLogs: TrafficLogGroups(),
        logByApplication: const IMapConst({}),
        logByDestination: const IMapConst({}),
        analysisByApplication: const IMapConst({}),
        analysisByDestination: const IMapConst({}),
        applicationsSortedFiltered: const IListConst([]),
        destinationsSortedFiltered: const IListConst([]),
        volumeType: settings.state.analysisVolumeType,
      );

  SessionLogAnalysisState clear() => copyWith(
    logs: logs.clear(),
    groupedLogs: TrafficLogGroups(),
    logByApplication: logByApplication.clear(),
    logByDestination: logByDestination.clear(),
    analysisByApplication: analysisByApplication.clear(),
    analysisByDestination: analysisByDestination.clear(),
    applicationsSortedFiltered: applicationsSortedFiltered.clear(),
    destinationsSortedFiltered: destinationsSortedFiltered.clear(),
  );

  @override
  final AnalysisView view;
  @override
  final SessionChartFilterCubit chartFilterCubit;
  SessionChartFilterState get chartFilter => chartFilterCubit.state;
  @override
  final DateTime? lastSort;

  @override
  final IList<TrafficLog> logs;
  @override
  final TrafficLogGroups groupedLogs;

  @override
  final IMap<String?, IList<TrafficLog>> logByApplication;
  @override
  final IMap<String, IList<TrafficLog>> logByDestination;
  @override
  final IMap<String?, TrafficLogByApplication> analysisByApplication;
  @override
  final IMap<String, TrafficLogByDestination> analysisByDestination;

  @override
  final IList<String?> applicationsSortedFiltered;
  @override
  final IList<String> destinationsSortedFiltered;

  final VolumeType volumeType;

  bool get hasLogs => logs.notEmpty;

  Iterable<TrafficLogByApplication> listAnalysisByApplication() {
    return applicationsSortedFiltered
        .map((a) => analysisByApplication[a])
        .nonNulls;
  }

  Iterable<TrafficLogByDestination> listAnalysisByDestination() {
    return destinationsSortedFiltered
        .map((d) => analysisByDestination[d])
        .nonNulls;
  }

  Iterable<TrafficLogAggregation> forType(GroupType type) => switch (type) {
    GroupType.application => listAnalysisByApplication().toList(),
    GroupType.destination => listAnalysisByDestination().toList(),
  };
}

enum AnalysisView { logs, chart }
