// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rule _$RuleFromJson(Map<String, dynamic> json) => Rule(
  id: json['id'] as String,
  targetVersion: json['targetVersion'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  active: json['active'] as bool? ?? true,
  type: $enumDecode(_$RuleTypeEnumMap, json['type']),
  blockQuic: json['blockQuic'] as bool? ?? false,
  packageName: json['packageName'] as String?,
  hosts:
      (json['hosts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ) ??
      const <String, bool>{},
  ips:
      (json['ips'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ) ??
      const <String, bool>{},
);

Map<String, dynamic> _$RuleToJson(Rule instance) => <String, dynamic>{
  'packageName': instance.packageName,
  'type': _$RuleTypeEnumMap[instance.type]!,
  'blockQuic': instance.blockQuic,
  'hosts': instance.hosts,
  'ips': instance.ips,
  'id': instance.id,
  'name': instance.name,
  'targetVersion': instance.targetVersion,
  'description': instance.description,
  'active': instance.active,
};

const _$RuleTypeEnumMap = {
  RuleType.blacklist: 'blacklist',
  RuleType.whitelist: 'whitelist',
};
