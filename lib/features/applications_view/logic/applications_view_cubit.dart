import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:netguard/netguard.dart';

import 'application_entry_cubit.dart';

part 'applications_view_cubit.freezed.dart';

class ApplicationsViewCubit extends Cubit<ApplicationsViewState> {
  ApplicationsViewCubit() : super(const ApplicationsViewState()) {
    _load();
  }

  final List<StreamSubscription> _entryListener = [];

  @override
  Future close() async {
    super.close();
    while(_entryListener.isNotEmpty) {
      await _entryListener.removeLast().cancel();
    }
    for (var e in state.entries) {
      await e.close();
    }
  }

  void _load() {
    List<ApplicationEntryCubit> thirdParty = _applicationsToCubits(
      sessionCubit.state.thirdPartyApplications,
    );
    List<ApplicationEntryCubit> system = _applicationsToCubits(
      sessionCubit.state.systemApplications,
    );
    emit(
      state.copyWith(
        thirdPartyEntries: thirdParty,
        systemEntries: system,
      ),
    );
  }

  List<ApplicationEntryCubit> _applicationsToCubits(
    List<Application> applications,
  ) {
    List<ApplicationEntryCubit> cubits = [];
    for (var app in applications) {
      if (app.setting == null) {
        throw Exception("All applications should have a setting assigned");
      }
      var cubit = ApplicationEntryCubit(app, app.setting!);
      _entryListener.add(cubit.stream.listen(onCubitChanged));
      cubits.add(cubit);
    }
    return cubits;
  }


  void updateAllEnabled() {
    emit(
      state.copyWith(
        thirdPartyAllEnabled: state.thirdPartyEntries.every(
          (e) => e.state.filter,
        ),
        systemAllEnabled: state.systemEntries.every(
          (e) => e.state.filter,
        ),
      ),
    );
  }
  Future setFilterForAll(List<ApplicationEntryCubit> cubits, bool filter)async{
    _updateOnCubitChange = false;
    for(var cubit in cubits){
      cubit.setFilter(filter);
    }
    // small async gap to ensure cubits are updated before we listen for updates again
    Future.delayed(Duration(milliseconds: 100), (){
      updateAllEnabled();
      _updateOnCubitChange = true;
    });
  }

  // TODO: this is not working reliably, if at all....
  bool _updateOnCubitChange = true;
  void onCubitChanged(ApplicationEntryState state) {
    if(_updateOnCubitChange) updateAllEnabled();
  }
}

@freezed
class ApplicationsViewState with _$ApplicationsViewState {
  const ApplicationsViewState({
    this.thirdPartyEntries = const [],
    this.systemEntries = const [],
    this.thirdPartyAllEnabled = false,
    this.systemAllEnabled = false,
  });

  @override
  final bool thirdPartyAllEnabled;
  @override
  final bool systemAllEnabled;
  @override
  final List<ApplicationEntryCubit> thirdPartyEntries;
  @override
  final List<ApplicationEntryCubit> systemEntries;

  List<ApplicationEntryCubit> get entries => [
    ...thirdPartyEntries,
    ...systemEntries,
  ];
}
