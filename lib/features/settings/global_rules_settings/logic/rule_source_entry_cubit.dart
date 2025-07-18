import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/data/data.dart';

part 'rule_source_entry_cubit.freezed.dart';

class RuleSourceEntryCubit extends Cubit<RuleSourceEntryState> {
  RuleSourceEntryCubit(GlobalRuleSource source)
    : super(RuleSourceEntryState.fromSource(source));

  void updateSource(String source) {
    emit(state.copyWith(source: source));
  }
}

@freezed
class RuleSourceEntryState with _$RuleSourceEntryState {
  RuleSourceEntryState({required this.source, required this.type});
  RuleSourceEntryState.fromSource(GlobalRuleSource source)
    : this(source: source.source, type: source.type);

  @override
  final String source;
  @override
  final SourceType type;

  GlobalRuleSource get entity => GlobalRuleSource(source: source, type: type);
}
