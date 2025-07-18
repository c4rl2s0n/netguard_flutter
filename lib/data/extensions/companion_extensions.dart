import 'package:drift/drift.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

extension ApplicationSettingToCompanion on ApplicationSetting {
  ApplicationSettingTableCompanion get companion =>
      ApplicationSettingTableCompanion(
        packageName: Value(packageName),
        filter: Value(filter),
      );
}

extension BlacklistToCompanion on BlacklistEntry {
  BlacklistTableCompanion get companion => BlacklistTableCompanion(
    ruleId: Value(ruleId),
    target: Value(target),
    type: Value(type),
    source: Value(source),
  );
}

extension GlobalRuleSourceToCompanion on GlobalRuleSource{
  GlobalRuleSourceTableCompanion get companion => GlobalRuleSourceTableCompanion(
    source: Value(source),
    type: Value(type),
  );
}

extension ResourceRecordToCompanion on ResourceRecord {
  ResourceRecordTableCompanion get companion => ResourceRecordTableCompanion(
    time: Value(time),
    qName: Value(qName),
    aName: Value(aName),
    resource: Value(resource),
    ttl: Value(ttl),
    uid: Value(uid),
  );
}

extension RuleToCompanion on Rule {
  RulesTableCompanion get companion => RulesTableCompanion(
    id: Value(id),
    packageName: packageName.notEmpty ? Value(packageName!) : Value.absent(),
    targetVersion: Value(targetVersion),
    description: Value(description),
  );
}

extension SettingsToCompanion on Settings {
  SettingsTableCompanion get companion => SettingsTableCompanion.insert(
    id: Value(0),
    darkMode: darkMode,
    colorScheme: colorScheme,
    includeSystemApps: includeSystemApps,
  );
}
