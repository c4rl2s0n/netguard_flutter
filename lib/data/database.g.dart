// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ApplicationSettingTableTable extends ApplicationSettingTable
    with TableInfo<$ApplicationSettingTableTable, ApplicationSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApplicationSettingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _packageNameMeta = const VerificationMeta(
    'packageName',
  );
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
    'package_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filterMeta = const VerificationMeta('filter');
  @override
  late final GeneratedColumn<bool> filter = GeneratedColumn<bool>(
    'filter',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("filter" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [packageName, filter];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'application_setting_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApplicationSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('package_name')) {
      context.handle(
        _packageNameMeta,
        packageName.isAcceptableOrUnknown(
          data['package_name']!,
          _packageNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('filter')) {
      context.handle(
        _filterMeta,
        filter.isAcceptableOrUnknown(data['filter']!, _filterMeta),
      );
    } else if (isInserting) {
      context.missing(_filterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {packageName};
  @override
  ApplicationSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApplicationSetting(
      packageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_name'],
      )!,
      filter: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}filter'],
      )!,
    );
  }

  @override
  $ApplicationSettingTableTable createAlias(String alias) {
    return $ApplicationSettingTableTable(attachedDatabase, alias);
  }
}

class ApplicationSettingTableCompanion
    extends UpdateCompanion<ApplicationSetting> {
  final Value<String> packageName;
  final Value<bool> filter;
  final Value<int> rowid;
  const ApplicationSettingTableCompanion({
    this.packageName = const Value.absent(),
    this.filter = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApplicationSettingTableCompanion.insert({
    required String packageName,
    required bool filter,
    this.rowid = const Value.absent(),
  }) : packageName = Value(packageName),
       filter = Value(filter);
  static Insertable<ApplicationSetting> custom({
    Expression<String>? packageName,
    Expression<bool>? filter,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (packageName != null) 'package_name': packageName,
      if (filter != null) 'filter': filter,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApplicationSettingTableCompanion copyWith({
    Value<String>? packageName,
    Value<bool>? filter,
    Value<int>? rowid,
  }) {
    return ApplicationSettingTableCompanion(
      packageName: packageName ?? this.packageName,
      filter: filter ?? this.filter,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (filter.present) {
      map['filter'] = Variable<bool>(filter.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationSettingTableCompanion(')
          ..write('packageName: $packageName, ')
          ..write('filter: $filter, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RulesTableTable extends RulesTable
    with TableInfo<$RulesTableTable, Rule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => IdTools.generateUuid(),
  );
  static const VerificationMeta _packageNameMeta = const VerificationMeta(
    'packageName',
  );
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
    'package_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetVersionMeta = const VerificationMeta(
    'targetVersion',
  );
  @override
  late final GeneratedColumn<String> targetVersion = GeneratedColumn<String>(
    'target_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    packageName,
    targetVersion,
    description,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rules_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Rule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('package_name')) {
      context.handle(
        _packageNameMeta,
        packageName.isAcceptableOrUnknown(
          data['package_name']!,
          _packageNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('target_version')) {
      context.handle(
        _targetVersionMeta,
        targetVersion.isAcceptableOrUnknown(
          data['target_version']!,
          _targetVersionMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Rule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      targetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_version'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      packageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_name'],
      )!,
    );
  }

  @override
  $RulesTableTable createAlias(String alias) {
    return $RulesTableTable(attachedDatabase, alias);
  }
}

class RulesTableCompanion extends UpdateCompanion<Rule> {
  final Value<String> id;
  final Value<String> packageName;
  final Value<String?> targetVersion;
  final Value<String?> description;
  final Value<bool> active;
  final Value<int> rowid;
  const RulesTableCompanion({
    this.id = const Value.absent(),
    this.packageName = const Value.absent(),
    this.targetVersion = const Value.absent(),
    this.description = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RulesTableCompanion.insert({
    this.id = const Value.absent(),
    required String packageName,
    this.targetVersion = const Value.absent(),
    this.description = const Value.absent(),
    required bool active,
    this.rowid = const Value.absent(),
  }) : packageName = Value(packageName),
       active = Value(active);
  static Insertable<Rule> custom({
    Expression<String>? id,
    Expression<String>? packageName,
    Expression<String>? targetVersion,
    Expression<String>? description,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (packageName != null) 'package_name': packageName,
      if (targetVersion != null) 'target_version': targetVersion,
      if (description != null) 'description': description,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RulesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? packageName,
    Value<String?>? targetVersion,
    Value<String?>? description,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return RulesTableCompanion(
      id: id ?? this.id,
      packageName: packageName ?? this.packageName,
      targetVersion: targetVersion ?? this.targetVersion,
      description: description ?? this.description,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (targetVersion.present) {
      map['target_version'] = Variable<String>(targetVersion.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RulesTableCompanion(')
          ..write('id: $id, ')
          ..write('packageName: $packageName, ')
          ..write('targetVersion: $targetVersion, ')
          ..write('description: $description, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BlacklistTableTable extends BlacklistTable
    with TableInfo<$BlacklistTableTable, BlacklistEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlacklistTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => IdTools.generateUuid(),
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<String> ruleId = GeneratedColumn<String>(
    'rule_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rules_table (id)',
    ),
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<String> target = GeneratedColumn<String>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BlacklistType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<BlacklistType>($BlacklistTableTable.$convertertype);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, ruleId, target, type, source];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blacklist_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BlacklistEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlacklistEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlacklistEntry(
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_id'],
      ),
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target'],
      )!,
      type: $BlacklistTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
    );
  }

  @override
  $BlacklistTableTable createAlias(String alias) {
    return $BlacklistTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BlacklistType, String, String> $convertertype =
      const EnumNameConverter<BlacklistType>(BlacklistType.values);
}

class BlacklistTableCompanion extends UpdateCompanion<BlacklistEntry> {
  final Value<String> id;
  final Value<String?> ruleId;
  final Value<String> target;
  final Value<BlacklistType> type;
  final Value<String?> source;
  final Value<int> rowid;
  const BlacklistTableCompanion({
    this.id = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.target = const Value.absent(),
    this.type = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BlacklistTableCompanion.insert({
    this.id = const Value.absent(),
    this.ruleId = const Value.absent(),
    required String target,
    required BlacklistType type,
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : target = Value(target),
       type = Value(type);
  static Insertable<BlacklistEntry> custom({
    Expression<String>? id,
    Expression<String>? ruleId,
    Expression<String>? target,
    Expression<String>? type,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleId != null) 'rule_id': ruleId,
      if (target != null) 'target': target,
      if (type != null) 'type': type,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BlacklistTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? ruleId,
    Value<String>? target,
    Value<BlacklistType>? type,
    Value<String?>? source,
    Value<int>? rowid,
  }) {
    return BlacklistTableCompanion(
      id: id ?? this.id,
      ruleId: ruleId ?? this.ruleId,
      target: target ?? this.target,
      type: type ?? this.type,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<String>(ruleId.value);
    }
    if (target.present) {
      map['target'] = Variable<String>(target.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $BlacklistTableTable.$convertertype.toSql(type.value),
      );
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlacklistTableCompanion(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('target: $target, ')
          ..write('type: $type, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, Settings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: () => 0,
  );
  static const VerificationMeta _darkModeMeta = const VerificationMeta(
    'darkMode',
  );
  @override
  late final GeneratedColumn<bool> darkMode = GeneratedColumn<bool>(
    'dark_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dark_mode" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<FlexScheme, String> colorScheme =
      GeneratedColumn<String>(
        'color_scheme',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FlexScheme>($SettingsTableTable.$convertercolorScheme);
  static const VerificationMeta _includeSystemAppsMeta = const VerificationMeta(
    'includeSystemApps',
  );
  @override
  late final GeneratedColumn<bool> includeSystemApps = GeneratedColumn<bool>(
    'include_system_apps',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("include_system_apps" IN (0, 1))',
    ),
  );
  static const VerificationMeta _lastBlacklistScanMeta = const VerificationMeta(
    'lastBlacklistScan',
  );
  @override
  late final GeneratedColumn<DateTime> lastBlacklistScan =
      GeneratedColumn<DateTime>(
        'last_blacklist_scan',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    darkMode,
    colorScheme,
    includeSystemApps,
    lastBlacklistScan,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Settings> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('dark_mode')) {
      context.handle(
        _darkModeMeta,
        darkMode.isAcceptableOrUnknown(data['dark_mode']!, _darkModeMeta),
      );
    } else if (isInserting) {
      context.missing(_darkModeMeta);
    }
    if (data.containsKey('include_system_apps')) {
      context.handle(
        _includeSystemAppsMeta,
        includeSystemApps.isAcceptableOrUnknown(
          data['include_system_apps']!,
          _includeSystemAppsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_includeSystemAppsMeta);
    }
    if (data.containsKey('last_blacklist_scan')) {
      context.handle(
        _lastBlacklistScanMeta,
        lastBlacklistScan.isAcceptableOrUnknown(
          data['last_blacklist_scan']!,
          _lastBlacklistScanMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Settings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Settings(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      darkMode: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dark_mode'],
      )!,
      colorScheme: $SettingsTableTable.$convertercolorScheme.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}color_scheme'],
        )!,
      ),
      includeSystemApps: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}include_system_apps'],
      )!,
      lastBlacklistScan: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_blacklist_scan'],
      ),
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FlexScheme, String, String> $convertercolorScheme =
      const EnumNameConverter<FlexScheme>(FlexScheme.values);
}

class SettingsTableCompanion extends UpdateCompanion<Settings> {
  final Value<int> id;
  final Value<bool> darkMode;
  final Value<FlexScheme> colorScheme;
  final Value<bool> includeSystemApps;
  final Value<DateTime?> lastBlacklistScan;
  const SettingsTableCompanion({
    this.id = const Value.absent(),
    this.darkMode = const Value.absent(),
    this.colorScheme = const Value.absent(),
    this.includeSystemApps = const Value.absent(),
    this.lastBlacklistScan = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    this.id = const Value.absent(),
    required bool darkMode,
    required FlexScheme colorScheme,
    required bool includeSystemApps,
    this.lastBlacklistScan = const Value.absent(),
  }) : darkMode = Value(darkMode),
       colorScheme = Value(colorScheme),
       includeSystemApps = Value(includeSystemApps);
  static Insertable<Settings> custom({
    Expression<int>? id,
    Expression<bool>? darkMode,
    Expression<String>? colorScheme,
    Expression<bool>? includeSystemApps,
    Expression<DateTime>? lastBlacklistScan,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (darkMode != null) 'dark_mode': darkMode,
      if (colorScheme != null) 'color_scheme': colorScheme,
      if (includeSystemApps != null) 'include_system_apps': includeSystemApps,
      if (lastBlacklistScan != null) 'last_blacklist_scan': lastBlacklistScan,
    });
  }

  SettingsTableCompanion copyWith({
    Value<int>? id,
    Value<bool>? darkMode,
    Value<FlexScheme>? colorScheme,
    Value<bool>? includeSystemApps,
    Value<DateTime?>? lastBlacklistScan,
  }) {
    return SettingsTableCompanion(
      id: id ?? this.id,
      darkMode: darkMode ?? this.darkMode,
      colorScheme: colorScheme ?? this.colorScheme,
      includeSystemApps: includeSystemApps ?? this.includeSystemApps,
      lastBlacklistScan: lastBlacklistScan ?? this.lastBlacklistScan,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (darkMode.present) {
      map['dark_mode'] = Variable<bool>(darkMode.value);
    }
    if (colorScheme.present) {
      map['color_scheme'] = Variable<String>(
        $SettingsTableTable.$convertercolorScheme.toSql(colorScheme.value),
      );
    }
    if (includeSystemApps.present) {
      map['include_system_apps'] = Variable<bool>(includeSystemApps.value);
    }
    if (lastBlacklistScan.present) {
      map['last_blacklist_scan'] = Variable<DateTime>(lastBlacklistScan.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('darkMode: $darkMode, ')
          ..write('colorScheme: $colorScheme, ')
          ..write('includeSystemApps: $includeSystemApps, ')
          ..write('lastBlacklistScan: $lastBlacklistScan')
          ..write(')'))
        .toString();
  }
}

class $ResourceRecordTableTable extends ResourceRecordTable
    with TableInfo<$ResourceRecordTableTable, ResourceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResourceRecordTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => IdTools.generateUuid(),
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int> time = GeneratedColumn<int>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qNameMeta = const VerificationMeta('qName');
  @override
  late final GeneratedColumn<String> qName = GeneratedColumn<String>(
    'q_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aNameMeta = const VerificationMeta('aName');
  @override
  late final GeneratedColumn<String> aName = GeneratedColumn<String>(
    'a_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resourceMeta = const VerificationMeta(
    'resource',
  );
  @override
  late final GeneratedColumn<String> resource = GeneratedColumn<String>(
    'resource',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ttlMeta = const VerificationMeta('ttl');
  @override
  late final GeneratedColumn<int> ttl = GeneratedColumn<int>(
    'ttl',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<int> uid = GeneratedColumn<int>(
    'uid',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    time,
    qName,
    aName,
    resource,
    ttl,
    uid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'resource_record_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ResourceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('q_name')) {
      context.handle(
        _qNameMeta,
        qName.isAcceptableOrUnknown(data['q_name']!, _qNameMeta),
      );
    } else if (isInserting) {
      context.missing(_qNameMeta);
    }
    if (data.containsKey('a_name')) {
      context.handle(
        _aNameMeta,
        aName.isAcceptableOrUnknown(data['a_name']!, _aNameMeta),
      );
    } else if (isInserting) {
      context.missing(_aNameMeta);
    }
    if (data.containsKey('resource')) {
      context.handle(
        _resourceMeta,
        resource.isAcceptableOrUnknown(data['resource']!, _resourceMeta),
      );
    } else if (isInserting) {
      context.missing(_resourceMeta);
    }
    if (data.containsKey('ttl')) {
      context.handle(
        _ttlMeta,
        ttl.isAcceptableOrUnknown(data['ttl']!, _ttlMeta),
      );
    }
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ResourceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResourceRecord(
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time'],
      )!,
      qName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}q_name'],
      )!,
      aName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}a_name'],
      )!,
      resource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resource'],
      )!,
      ttl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ttl'],
      ),
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}uid'],
      ),
    );
  }

  @override
  $ResourceRecordTableTable createAlias(String alias) {
    return $ResourceRecordTableTable(attachedDatabase, alias);
  }
}

class ResourceRecordTableCompanion extends UpdateCompanion<ResourceRecord> {
  final Value<String> id;
  final Value<int> time;
  final Value<String> qName;
  final Value<String> aName;
  final Value<String> resource;
  final Value<int?> ttl;
  final Value<int?> uid;
  final Value<int> rowid;
  const ResourceRecordTableCompanion({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    this.qName = const Value.absent(),
    this.aName = const Value.absent(),
    this.resource = const Value.absent(),
    this.ttl = const Value.absent(),
    this.uid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ResourceRecordTableCompanion.insert({
    this.id = const Value.absent(),
    required int time,
    required String qName,
    required String aName,
    required String resource,
    this.ttl = const Value.absent(),
    this.uid = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : time = Value(time),
       qName = Value(qName),
       aName = Value(aName),
       resource = Value(resource);
  static Insertable<ResourceRecord> custom({
    Expression<String>? id,
    Expression<int>? time,
    Expression<String>? qName,
    Expression<String>? aName,
    Expression<String>? resource,
    Expression<int>? ttl,
    Expression<int>? uid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (time != null) 'time': time,
      if (qName != null) 'q_name': qName,
      if (aName != null) 'a_name': aName,
      if (resource != null) 'resource': resource,
      if (ttl != null) 'ttl': ttl,
      if (uid != null) 'uid': uid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ResourceRecordTableCompanion copyWith({
    Value<String>? id,
    Value<int>? time,
    Value<String>? qName,
    Value<String>? aName,
    Value<String>? resource,
    Value<int?>? ttl,
    Value<int?>? uid,
    Value<int>? rowid,
  }) {
    return ResourceRecordTableCompanion(
      id: id ?? this.id,
      time: time ?? this.time,
      qName: qName ?? this.qName,
      aName: aName ?? this.aName,
      resource: resource ?? this.resource,
      ttl: ttl ?? this.ttl,
      uid: uid ?? this.uid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (qName.present) {
      map['q_name'] = Variable<String>(qName.value);
    }
    if (aName.present) {
      map['a_name'] = Variable<String>(aName.value);
    }
    if (resource.present) {
      map['resource'] = Variable<String>(resource.value);
    }
    if (ttl.present) {
      map['ttl'] = Variable<int>(ttl.value);
    }
    if (uid.present) {
      map['uid'] = Variable<int>(uid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResourceRecordTableCompanion(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('qName: $qName, ')
          ..write('aName: $aName, ')
          ..write('resource: $resource, ')
          ..write('ttl: $ttl, ')
          ..write('uid: $uid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GlobalRuleSourceTableTable extends GlobalRuleSourceTable
    with TableInfo<$GlobalRuleSourceTableTable, GlobalRuleSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GlobalRuleSourceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => IdTools.generateUuid(),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SourceType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SourceType>($GlobalRuleSourceTableTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [id, source, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'global_rule_source_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GlobalRuleSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GlobalRuleSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GlobalRuleSource(
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      type: $GlobalRuleSourceTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $GlobalRuleSourceTableTable createAlias(String alias) {
    return $GlobalRuleSourceTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SourceType, String, String> $convertertype =
      const EnumNameConverter<SourceType>(SourceType.values);
}

class GlobalRuleSourceTableCompanion extends UpdateCompanion<GlobalRuleSource> {
  final Value<String> id;
  final Value<String> source;
  final Value<SourceType> type;
  final Value<int> rowid;
  const GlobalRuleSourceTableCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.type = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GlobalRuleSourceTableCompanion.insert({
    this.id = const Value.absent(),
    required String source,
    required SourceType type,
    this.rowid = const Value.absent(),
  }) : source = Value(source),
       type = Value(type);
  static Insertable<GlobalRuleSource> custom({
    Expression<String>? id,
    Expression<String>? source,
    Expression<String>? type,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (type != null) 'type': type,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GlobalRuleSourceTableCompanion copyWith({
    Value<String>? id,
    Value<String>? source,
    Value<SourceType>? type,
    Value<int>? rowid,
  }) {
    return GlobalRuleSourceTableCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      type: type ?? this.type,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $GlobalRuleSourceTableTable.$convertertype.toSql(type.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GlobalRuleSourceTableCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('type: $type, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ApplicationSettingTableTable applicationSettingTable =
      $ApplicationSettingTableTable(this);
  late final $RulesTableTable rulesTable = $RulesTableTable(this);
  late final $BlacklistTableTable blacklistTable = $BlacklistTableTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $ResourceRecordTableTable resourceRecordTable =
      $ResourceRecordTableTable(this);
  late final $GlobalRuleSourceTableTable globalRuleSourceTable =
      $GlobalRuleSourceTableTable(this);
  late final Index blacklistRuleIndex = Index(
    'blacklistRuleIndex',
    'CREATE INDEX blacklistRuleIndex ON blacklist_table (rule_id)',
  );
  late final Index blacklistTypeIndex = Index(
    'blacklistTypeIndex',
    'CREATE INDEX blacklistTypeIndex ON blacklist_table (type)',
  );
  late final Index package = Index(
    'package',
    'CREATE INDEX package ON rules_table (package_name)',
  );
  late final Index indexDns = Index(
    'indexDns',
    'CREATE UNIQUE INDEX indexDns ON resource_record_table (q_name, a_name, resource)',
  );
  late final Index indexDnsResource = Index(
    'indexDnsResource',
    'CREATE INDEX indexDnsResource ON resource_record_table (resource)',
  );
  late final Index globalRuleTypeIndex = Index(
    'globalRuleTypeIndex',
    'CREATE INDEX globalRuleTypeIndex ON global_rule_source_table (type)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    applicationSettingTable,
    rulesTable,
    blacklistTable,
    settingsTable,
    resourceRecordTable,
    globalRuleSourceTable,
    blacklistRuleIndex,
    blacklistTypeIndex,
    package,
    indexDns,
    indexDnsResource,
    globalRuleTypeIndex,
  ];
}

typedef $$ApplicationSettingTableTableCreateCompanionBuilder =
    ApplicationSettingTableCompanion Function({
      required String packageName,
      required bool filter,
      Value<int> rowid,
    });
typedef $$ApplicationSettingTableTableUpdateCompanionBuilder =
    ApplicationSettingTableCompanion Function({
      Value<String> packageName,
      Value<bool> filter,
      Value<int> rowid,
    });

class $$ApplicationSettingTableTableFilterComposer
    extends Composer<_$AppDatabase, $ApplicationSettingTableTable> {
  $$ApplicationSettingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get filter => $composableBuilder(
    column: $table.filter,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ApplicationSettingTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ApplicationSettingTableTable> {
  $$ApplicationSettingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get filter => $composableBuilder(
    column: $table.filter,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ApplicationSettingTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApplicationSettingTableTable> {
  $$ApplicationSettingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get filter =>
      $composableBuilder(column: $table.filter, builder: (column) => column);
}

class $$ApplicationSettingTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApplicationSettingTableTable,
          ApplicationSetting,
          $$ApplicationSettingTableTableFilterComposer,
          $$ApplicationSettingTableTableOrderingComposer,
          $$ApplicationSettingTableTableAnnotationComposer,
          $$ApplicationSettingTableTableCreateCompanionBuilder,
          $$ApplicationSettingTableTableUpdateCompanionBuilder,
          (
            ApplicationSetting,
            BaseReferences<
              _$AppDatabase,
              $ApplicationSettingTableTable,
              ApplicationSetting
            >,
          ),
          ApplicationSetting,
          PrefetchHooks Function()
        > {
  $$ApplicationSettingTableTableTableManager(
    _$AppDatabase db,
    $ApplicationSettingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApplicationSettingTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ApplicationSettingTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ApplicationSettingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> packageName = const Value.absent(),
                Value<bool> filter = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApplicationSettingTableCompanion(
                packageName: packageName,
                filter: filter,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String packageName,
                required bool filter,
                Value<int> rowid = const Value.absent(),
              }) => ApplicationSettingTableCompanion.insert(
                packageName: packageName,
                filter: filter,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ApplicationSettingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApplicationSettingTableTable,
      ApplicationSetting,
      $$ApplicationSettingTableTableFilterComposer,
      $$ApplicationSettingTableTableOrderingComposer,
      $$ApplicationSettingTableTableAnnotationComposer,
      $$ApplicationSettingTableTableCreateCompanionBuilder,
      $$ApplicationSettingTableTableUpdateCompanionBuilder,
      (
        ApplicationSetting,
        BaseReferences<
          _$AppDatabase,
          $ApplicationSettingTableTable,
          ApplicationSetting
        >,
      ),
      ApplicationSetting,
      PrefetchHooks Function()
    >;
typedef $$RulesTableTableCreateCompanionBuilder =
    RulesTableCompanion Function({
      Value<String> id,
      required String packageName,
      Value<String?> targetVersion,
      Value<String?> description,
      required bool active,
      Value<int> rowid,
    });
typedef $$RulesTableTableUpdateCompanionBuilder =
    RulesTableCompanion Function({
      Value<String> id,
      Value<String> packageName,
      Value<String?> targetVersion,
      Value<String?> description,
      Value<bool> active,
      Value<int> rowid,
    });

final class $$RulesTableTableReferences
    extends BaseReferences<_$AppDatabase, $RulesTableTable, Rule> {
  $$RulesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BlacklistTableTable, List<BlacklistEntry>>
  _blacklistTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.blacklistTable,
    aliasName: $_aliasNameGenerator(db.rulesTable.id, db.blacklistTable.ruleId),
  );

  $$BlacklistTableTableProcessedTableManager get blacklistTableRefs {
    final manager = $$BlacklistTableTableTableManager(
      $_db,
      $_db.blacklistTable,
    ).filter((f) => f.ruleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_blacklistTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RulesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RulesTableTable> {
  $$RulesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetVersion => $composableBuilder(
    column: $table.targetVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> blacklistTableRefs(
    Expression<bool> Function($$BlacklistTableTableFilterComposer f) f,
  ) {
    final $$BlacklistTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.blacklistTable,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlacklistTableTableFilterComposer(
            $db: $db,
            $table: $db.blacklistTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RulesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RulesTableTable> {
  $$RulesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetVersion => $composableBuilder(
    column: $table.targetVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RulesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RulesTableTable> {
  $$RulesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetVersion => $composableBuilder(
    column: $table.targetVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  Expression<T> blacklistTableRefs<T extends Object>(
    Expression<T> Function($$BlacklistTableTableAnnotationComposer a) f,
  ) {
    final $$BlacklistTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.blacklistTable,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlacklistTableTableAnnotationComposer(
            $db: $db,
            $table: $db.blacklistTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RulesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RulesTableTable,
          Rule,
          $$RulesTableTableFilterComposer,
          $$RulesTableTableOrderingComposer,
          $$RulesTableTableAnnotationComposer,
          $$RulesTableTableCreateCompanionBuilder,
          $$RulesTableTableUpdateCompanionBuilder,
          (Rule, $$RulesTableTableReferences),
          Rule,
          PrefetchHooks Function({bool blacklistTableRefs})
        > {
  $$RulesTableTableTableManager(_$AppDatabase db, $RulesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RulesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RulesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RulesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> packageName = const Value.absent(),
                Value<String?> targetVersion = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RulesTableCompanion(
                id: id,
                packageName: packageName,
                targetVersion: targetVersion,
                description: description,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String packageName,
                Value<String?> targetVersion = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required bool active,
                Value<int> rowid = const Value.absent(),
              }) => RulesTableCompanion.insert(
                id: id,
                packageName: packageName,
                targetVersion: targetVersion,
                description: description,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RulesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({blacklistTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (blacklistTableRefs) db.blacklistTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (blacklistTableRefs)
                    await $_getPrefetchedData<
                      Rule,
                      $RulesTableTable,
                      BlacklistEntry
                    >(
                      currentTable: table,
                      referencedTable: $$RulesTableTableReferences
                          ._blacklistTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RulesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).blacklistTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.ruleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RulesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RulesTableTable,
      Rule,
      $$RulesTableTableFilterComposer,
      $$RulesTableTableOrderingComposer,
      $$RulesTableTableAnnotationComposer,
      $$RulesTableTableCreateCompanionBuilder,
      $$RulesTableTableUpdateCompanionBuilder,
      (Rule, $$RulesTableTableReferences),
      Rule,
      PrefetchHooks Function({bool blacklistTableRefs})
    >;
typedef $$BlacklistTableTableCreateCompanionBuilder =
    BlacklistTableCompanion Function({
      Value<String> id,
      Value<String?> ruleId,
      required String target,
      required BlacklistType type,
      Value<String?> source,
      Value<int> rowid,
    });
typedef $$BlacklistTableTableUpdateCompanionBuilder =
    BlacklistTableCompanion Function({
      Value<String> id,
      Value<String?> ruleId,
      Value<String> target,
      Value<BlacklistType> type,
      Value<String?> source,
      Value<int> rowid,
    });

final class $$BlacklistTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $BlacklistTableTable, BlacklistEntry> {
  $$BlacklistTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RulesTableTable _ruleIdTable(_$AppDatabase db) =>
      db.rulesTable.createAlias(
        $_aliasNameGenerator(db.blacklistTable.ruleId, db.rulesTable.id),
      );

  $$RulesTableTableProcessedTableManager? get ruleId {
    final $_column = $_itemColumn<String>('rule_id');
    if ($_column == null) return null;
    final manager = $$RulesTableTableTableManager(
      $_db,
      $_db.rulesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BlacklistTableTableFilterComposer
    extends Composer<_$AppDatabase, $BlacklistTableTable> {
  $$BlacklistTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BlacklistType, BlacklistType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$RulesTableTableFilterComposer get ruleId {
    final $$RulesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rulesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableTableFilterComposer(
            $db: $db,
            $table: $db.rulesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BlacklistTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BlacklistTableTable> {
  $$BlacklistTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$RulesTableTableOrderingComposer get ruleId {
    final $$RulesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rulesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableTableOrderingComposer(
            $db: $db,
            $table: $db.rulesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BlacklistTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlacklistTableTable> {
  $$BlacklistTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BlacklistType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$RulesTableTableAnnotationComposer get ruleId {
    final $$RulesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rulesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.rulesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BlacklistTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BlacklistTableTable,
          BlacklistEntry,
          $$BlacklistTableTableFilterComposer,
          $$BlacklistTableTableOrderingComposer,
          $$BlacklistTableTableAnnotationComposer,
          $$BlacklistTableTableCreateCompanionBuilder,
          $$BlacklistTableTableUpdateCompanionBuilder,
          (BlacklistEntry, $$BlacklistTableTableReferences),
          BlacklistEntry,
          PrefetchHooks Function({bool ruleId})
        > {
  $$BlacklistTableTableTableManager(
    _$AppDatabase db,
    $BlacklistTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlacklistTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlacklistTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlacklistTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> ruleId = const Value.absent(),
                Value<String> target = const Value.absent(),
                Value<BlacklistType> type = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BlacklistTableCompanion(
                id: id,
                ruleId: ruleId,
                target: target,
                type: type,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> ruleId = const Value.absent(),
                required String target,
                required BlacklistType type,
                Value<String?> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BlacklistTableCompanion.insert(
                id: id,
                ruleId: ruleId,
                target: target,
                type: type,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BlacklistTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ruleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ruleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ruleId,
                                referencedTable: $$BlacklistTableTableReferences
                                    ._ruleIdTable(db),
                                referencedColumn:
                                    $$BlacklistTableTableReferences
                                        ._ruleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BlacklistTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BlacklistTableTable,
      BlacklistEntry,
      $$BlacklistTableTableFilterComposer,
      $$BlacklistTableTableOrderingComposer,
      $$BlacklistTableTableAnnotationComposer,
      $$BlacklistTableTableCreateCompanionBuilder,
      $$BlacklistTableTableUpdateCompanionBuilder,
      (BlacklistEntry, $$BlacklistTableTableReferences),
      BlacklistEntry,
      PrefetchHooks Function({bool ruleId})
    >;
typedef $$SettingsTableTableCreateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      required bool darkMode,
      required FlexScheme colorScheme,
      required bool includeSystemApps,
      Value<DateTime?> lastBlacklistScan,
    });
typedef $$SettingsTableTableUpdateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<int> id,
      Value<bool> darkMode,
      Value<FlexScheme> colorScheme,
      Value<bool> includeSystemApps,
      Value<DateTime?> lastBlacklistScan,
    });

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get darkMode => $composableBuilder(
    column: $table.darkMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FlexScheme, FlexScheme, String>
  get colorScheme => $composableBuilder(
    column: $table.colorScheme,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get includeSystemApps => $composableBuilder(
    column: $table.includeSystemApps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBlacklistScan => $composableBuilder(
    column: $table.lastBlacklistScan,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get darkMode => $composableBuilder(
    column: $table.darkMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorScheme => $composableBuilder(
    column: $table.colorScheme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get includeSystemApps => $composableBuilder(
    column: $table.includeSystemApps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBlacklistScan => $composableBuilder(
    column: $table.lastBlacklistScan,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get darkMode =>
      $composableBuilder(column: $table.darkMode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FlexScheme, String> get colorScheme =>
      $composableBuilder(
        column: $table.colorScheme,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get includeSystemApps => $composableBuilder(
    column: $table.includeSystemApps,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBlacklistScan => $composableBuilder(
    column: $table.lastBlacklistScan,
    builder: (column) => column,
  );
}

class $$SettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTableTable,
          Settings,
          $$SettingsTableTableFilterComposer,
          $$SettingsTableTableOrderingComposer,
          $$SettingsTableTableAnnotationComposer,
          $$SettingsTableTableCreateCompanionBuilder,
          $$SettingsTableTableUpdateCompanionBuilder,
          (
            Settings,
            BaseReferences<_$AppDatabase, $SettingsTableTable, Settings>,
          ),
          Settings,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableTableManager(_$AppDatabase db, $SettingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> darkMode = const Value.absent(),
                Value<FlexScheme> colorScheme = const Value.absent(),
                Value<bool> includeSystemApps = const Value.absent(),
                Value<DateTime?> lastBlacklistScan = const Value.absent(),
              }) => SettingsTableCompanion(
                id: id,
                darkMode: darkMode,
                colorScheme: colorScheme,
                includeSystemApps: includeSystemApps,
                lastBlacklistScan: lastBlacklistScan,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required bool darkMode,
                required FlexScheme colorScheme,
                required bool includeSystemApps,
                Value<DateTime?> lastBlacklistScan = const Value.absent(),
              }) => SettingsTableCompanion.insert(
                id: id,
                darkMode: darkMode,
                colorScheme: colorScheme,
                includeSystemApps: includeSystemApps,
                lastBlacklistScan: lastBlacklistScan,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTableTable,
      Settings,
      $$SettingsTableTableFilterComposer,
      $$SettingsTableTableOrderingComposer,
      $$SettingsTableTableAnnotationComposer,
      $$SettingsTableTableCreateCompanionBuilder,
      $$SettingsTableTableUpdateCompanionBuilder,
      (Settings, BaseReferences<_$AppDatabase, $SettingsTableTable, Settings>),
      Settings,
      PrefetchHooks Function()
    >;
typedef $$ResourceRecordTableTableCreateCompanionBuilder =
    ResourceRecordTableCompanion Function({
      Value<String> id,
      required int time,
      required String qName,
      required String aName,
      required String resource,
      Value<int?> ttl,
      Value<int?> uid,
      Value<int> rowid,
    });
typedef $$ResourceRecordTableTableUpdateCompanionBuilder =
    ResourceRecordTableCompanion Function({
      Value<String> id,
      Value<int> time,
      Value<String> qName,
      Value<String> aName,
      Value<String> resource,
      Value<int?> ttl,
      Value<int?> uid,
      Value<int> rowid,
    });

class $$ResourceRecordTableTableFilterComposer
    extends Composer<_$AppDatabase, $ResourceRecordTableTable> {
  $$ResourceRecordTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qName => $composableBuilder(
    column: $table.qName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aName => $composableBuilder(
    column: $table.aName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resource => $composableBuilder(
    column: $table.resource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ttl => $composableBuilder(
    column: $table.ttl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ResourceRecordTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ResourceRecordTableTable> {
  $$ResourceRecordTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qName => $composableBuilder(
    column: $table.qName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aName => $composableBuilder(
    column: $table.aName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resource => $composableBuilder(
    column: $table.resource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ttl => $composableBuilder(
    column: $table.ttl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ResourceRecordTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResourceRecordTableTable> {
  $$ResourceRecordTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get qName =>
      $composableBuilder(column: $table.qName, builder: (column) => column);

  GeneratedColumn<String> get aName =>
      $composableBuilder(column: $table.aName, builder: (column) => column);

  GeneratedColumn<String> get resource =>
      $composableBuilder(column: $table.resource, builder: (column) => column);

  GeneratedColumn<int> get ttl =>
      $composableBuilder(column: $table.ttl, builder: (column) => column);

  GeneratedColumn<int> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);
}

class $$ResourceRecordTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResourceRecordTableTable,
          ResourceRecord,
          $$ResourceRecordTableTableFilterComposer,
          $$ResourceRecordTableTableOrderingComposer,
          $$ResourceRecordTableTableAnnotationComposer,
          $$ResourceRecordTableTableCreateCompanionBuilder,
          $$ResourceRecordTableTableUpdateCompanionBuilder,
          (
            ResourceRecord,
            BaseReferences<
              _$AppDatabase,
              $ResourceRecordTableTable,
              ResourceRecord
            >,
          ),
          ResourceRecord,
          PrefetchHooks Function()
        > {
  $$ResourceRecordTableTableTableManager(
    _$AppDatabase db,
    $ResourceRecordTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResourceRecordTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResourceRecordTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ResourceRecordTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> time = const Value.absent(),
                Value<String> qName = const Value.absent(),
                Value<String> aName = const Value.absent(),
                Value<String> resource = const Value.absent(),
                Value<int?> ttl = const Value.absent(),
                Value<int?> uid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ResourceRecordTableCompanion(
                id: id,
                time: time,
                qName: qName,
                aName: aName,
                resource: resource,
                ttl: ttl,
                uid: uid,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required int time,
                required String qName,
                required String aName,
                required String resource,
                Value<int?> ttl = const Value.absent(),
                Value<int?> uid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ResourceRecordTableCompanion.insert(
                id: id,
                time: time,
                qName: qName,
                aName: aName,
                resource: resource,
                ttl: ttl,
                uid: uid,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ResourceRecordTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResourceRecordTableTable,
      ResourceRecord,
      $$ResourceRecordTableTableFilterComposer,
      $$ResourceRecordTableTableOrderingComposer,
      $$ResourceRecordTableTableAnnotationComposer,
      $$ResourceRecordTableTableCreateCompanionBuilder,
      $$ResourceRecordTableTableUpdateCompanionBuilder,
      (
        ResourceRecord,
        BaseReferences<
          _$AppDatabase,
          $ResourceRecordTableTable,
          ResourceRecord
        >,
      ),
      ResourceRecord,
      PrefetchHooks Function()
    >;
typedef $$GlobalRuleSourceTableTableCreateCompanionBuilder =
    GlobalRuleSourceTableCompanion Function({
      Value<String> id,
      required String source,
      required SourceType type,
      Value<int> rowid,
    });
typedef $$GlobalRuleSourceTableTableUpdateCompanionBuilder =
    GlobalRuleSourceTableCompanion Function({
      Value<String> id,
      Value<String> source,
      Value<SourceType> type,
      Value<int> rowid,
    });

class $$GlobalRuleSourceTableTableFilterComposer
    extends Composer<_$AppDatabase, $GlobalRuleSourceTableTable> {
  $$GlobalRuleSourceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SourceType, SourceType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$GlobalRuleSourceTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GlobalRuleSourceTableTable> {
  $$GlobalRuleSourceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GlobalRuleSourceTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GlobalRuleSourceTableTable> {
  $$GlobalRuleSourceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SourceType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$GlobalRuleSourceTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GlobalRuleSourceTableTable,
          GlobalRuleSource,
          $$GlobalRuleSourceTableTableFilterComposer,
          $$GlobalRuleSourceTableTableOrderingComposer,
          $$GlobalRuleSourceTableTableAnnotationComposer,
          $$GlobalRuleSourceTableTableCreateCompanionBuilder,
          $$GlobalRuleSourceTableTableUpdateCompanionBuilder,
          (
            GlobalRuleSource,
            BaseReferences<
              _$AppDatabase,
              $GlobalRuleSourceTableTable,
              GlobalRuleSource
            >,
          ),
          GlobalRuleSource,
          PrefetchHooks Function()
        > {
  $$GlobalRuleSourceTableTableTableManager(
    _$AppDatabase db,
    $GlobalRuleSourceTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GlobalRuleSourceTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$GlobalRuleSourceTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GlobalRuleSourceTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<SourceType> type = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GlobalRuleSourceTableCompanion(
                id: id,
                source: source,
                type: type,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String source,
                required SourceType type,
                Value<int> rowid = const Value.absent(),
              }) => GlobalRuleSourceTableCompanion.insert(
                id: id,
                source: source,
                type: type,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GlobalRuleSourceTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GlobalRuleSourceTableTable,
      GlobalRuleSource,
      $$GlobalRuleSourceTableTableFilterComposer,
      $$GlobalRuleSourceTableTableOrderingComposer,
      $$GlobalRuleSourceTableTableAnnotationComposer,
      $$GlobalRuleSourceTableTableCreateCompanionBuilder,
      $$GlobalRuleSourceTableTableUpdateCompanionBuilder,
      (
        GlobalRuleSource,
        BaseReferences<
          _$AppDatabase,
          $GlobalRuleSourceTableTable,
          GlobalRuleSource
        >,
      ),
      GlobalRuleSource,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ApplicationSettingTableTableTableManager get applicationSettingTable =>
      $$ApplicationSettingTableTableTableManager(
        _db,
        _db.applicationSettingTable,
      );
  $$RulesTableTableTableManager get rulesTable =>
      $$RulesTableTableTableManager(_db, _db.rulesTable);
  $$BlacklistTableTableTableManager get blacklistTable =>
      $$BlacklistTableTableTableManager(_db, _db.blacklistTable);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$ResourceRecordTableTableTableManager get resourceRecordTable =>
      $$ResourceRecordTableTableTableManager(_db, _db.resourceRecordTable);
  $$GlobalRuleSourceTableTableTableManager get globalRuleSourceTable =>
      $$GlobalRuleSourceTableTableTableManager(_db, _db.globalRuleSourceTable);
}
