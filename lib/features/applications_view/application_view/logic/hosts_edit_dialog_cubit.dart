
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/netguard.dart';

part 'hosts_edit_dialog_cubit.freezed.dart';

class HostsEditDialogCubit extends Cubit<HostsEditDialogState>{
  HostsEditDialogCubit(Rule rule) : super(HostsEditDialogState());

}

@freezed
class HostsEditDialogState with _$HostsEditDialogState {
  HostsEditDialogState();

}
