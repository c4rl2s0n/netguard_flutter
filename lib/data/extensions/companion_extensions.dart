import 'package:drift/drift.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

extension ApplicationSettingToCompanion on ApplicationSetting {
  ApplicationSettingTableCompanion get companion =>
      ApplicationSettingTableCompanion(
        packageName: Value(packageName),
        filter: Value(filter),
        blockAll: Value(blockAll),
        blockQuic: Value(blockQuic),
      );
}

extension HostToCompanion on HostEntry {
  HostsTableCompanion get companion => HostsTableCompanion(
    ruleId: Value(ruleId),
    target: Value(target),
    type: Value(type),
    source: Value(source),
  );
}

extension GlobalRuleSourceToCompanion on GlobalRuleSource {
  GlobalRuleSourceTableCompanion get companion =>
      GlobalRuleSourceTableCompanion(source: Value(source), type: Value(type));
}

extension PackageStatisticsToCompanion on PackageStatistics {
  PackageStatisticsTableCompanion get companion =>
      PackageStatisticsTableCompanion(
        packageName: Value(packageName),
        packetCountAllowed: Value(packetCountAllowed),
        packetSizeAllowed: Value(packetSizeAllowed),
        packetCountBlocked: Value(packetCountBlocked),
        packetSizeBlocked: Value(packetSizeBlocked),
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
    packageName: packageName.notEmpty
        ? Value(packageName!)
        : Value(""), // TODO: check this...
    targetVersion: Value(targetVersion),
    name: Value(name),
    description: Value(description),
    active: Value(active),
    type: Value(type),
    shouldBlockQuic: Value(shouldBlockQuic),
    whitelistExclusive: Value(whitelistExclusive),
  );
}

extension SettingsToCompanion on Settings {
  SettingsTableCompanion get companion => SettingsTableCompanion.insert(
    id: Value(0),
    darkMode: darkMode,
    colorScheme: colorScheme,
    includeSystemApps: includeSystemApps,
    logTraffic: logTraffic,
    logCompactView: logCompactView,
    lastHostlistUpdate: Value(lastHostlistUpdate),
    analysisSettingsVolumeType: analysisSettingsVolumeType,
    chartSettingsSorting: chartSettingsSorting,
    chartSettingsChartType: chartSettingsChartType,
    chartSettingsGroupType: chartSettingsGroupType,
    chartSettingsSingleBar: chartSettingsSingleBar,
  );
}

extension TrafficLogToCompanion on TrafficLog {
  TrafficLogTableCompanion get companion => TrafficLogTableCompanion(
    id: Value(IdTools.generateUuid()),
    time: Value(time),
    session: Value(session),
    protocol: Value(protocol),
    packageName: Value(packageName),
    ip: Value(ip),
    host: Value(host),
    allowed: Value(allowed),
  );
}
