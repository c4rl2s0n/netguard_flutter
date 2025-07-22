import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/data/data.dart';

part 'hosts_edit_entry_cubit.freezed.dart';

class HostsEditEntryCubit extends Cubit<HostsEditEntryState> {
  HostsEditEntryCubit(HostEntry entry, bool selected) : super(HostsEditEntryState(entry: entry, selected: selected));

  void toggleSelection(){
    emit(state.copyWith(selected: !state.selected));
  }
}

@freezed
class HostsEditEntryState with _$HostsEditEntryState {
  HostsEditEntryState({required this.entry, required this.selected});

  final HostEntry entry;
  final bool selected;
}
