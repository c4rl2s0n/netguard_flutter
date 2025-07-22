import 'package:json_annotation/json_annotation.dart';
import 'package:netguard/common/native/native_bridge.g.dart' as native;
import 'package:netguard/common/native/native_bridge.g.dart' show RuleType;

part 'rule.g.dart';

@JsonSerializable()
class Rule extends native.Rule {
  Rule({
    required this.id,
    this.targetVersion,
    this.name,
    this.description,
    this.active = true,
    required super.type,
    super.blockQuic = false,
    super.packageName,
    super.hosts = const <String, bool>{},
    super.ips = const <String, bool>{},
  });

  String id;
  String? name;
  String? targetVersion;
  String? description;
  bool active;

  factory Rule.fromJson(Map<String, dynamic> json) => _$RuleFromJson(json);
}
