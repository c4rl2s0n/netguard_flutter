import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:netguard/netguard.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'tables/tables.dart';

//import 'database.steps.dart';
part 'database.g.dart';

@DriftDatabase(
  tables: [
    ApplicationSettingTable,
    BlacklistTable,
    RulesTable,
    SettingsTable,
    ResourceRecordTable,
    GlobalRuleSourceTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async => await m.createAll(),
      //onUpgrade: stepByStep(),
      beforeOpen: (details) async {
        if (!details.hadUpgrade && !details.wasCreated) return;
        bool reachedTarget(int target) =>
            (details.wasCreated ||
                details.versionBefore != null &&
                    details.versionBefore! < target) &&
            details.versionNow >= target;

        if (reachedTarget(1)) {
          // 18.07.2025
          List<String> defaultBlacklistOnlineSources = [
            "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext",
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-only/hosts",
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-only/hosts",
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn-only/hosts",
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/social-only/hosts",
            "https://hblock.molinero.dev/hosts",
            "https://blocklistproject.github.io/Lists/abuse.txt",
            "https://blocklistproject.github.io/Lists/ads.txt",
            "https://blocklistproject.github.io/Lists/crypto.txt",
            "https://blocklistproject.github.io/Lists/drugs.txt",
            "https://blocklistproject.github.io/Lists/facebook.txt",
            "https://blocklistproject.github.io/Lists/fraud.txt",
            "https://blocklistproject.github.io/Lists/gambling.txt",
            "https://blocklistproject.github.io/Lists/malware.txt",
            "https://blocklistproject.github.io/Lists/phishing.txt",
            "https://blocklistproject.github.io/Lists/piracy.txt",
            "https://blocklistproject.github.io/Lists/porn.txt",
            "https://blocklistproject.github.io/Lists/ransomware.txt",
            "https://blocklistproject.github.io/Lists/redirect.txt",
            "https://blocklistproject.github.io/Lists/scam.txt",
            "https://blocklistproject.github.io/Lists/tiktok.txt",
            "https://blocklistproject.github.io/Lists/torrent.txt",
            "https://blocklistproject.github.io/Lists/tracking.txt",
            "https://urlhaus.abuse.ch/downloads/hostfile/",
            "https://raw.githubusercontent.com/ph00lt0/blocklist/refs/heads/master/hosts-blocklist.txt", // AdGuard
            "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/refs/heads/master/hosts/hosts0",
            "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/refs/heads/master/hosts/hosts1",
            "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/refs/heads/master/hosts/hosts2",
            "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/refs/heads/master/hosts/hosts3",
            "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/refs/heads/master/hosts/hosts4",
            "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/refs/heads/master/hosts/hosts5",
            "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/refs/heads/master/hosts/hosts6",
            "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/refs/heads/master/ips/ips0.list",
          ];
          await batch(
            (b) => b.insertAllOnConflictUpdate(
              globalRuleSourceTable,
              defaultBlacklistOnlineSources.map(
                (s) => GlobalRuleSource(
                  source: s,
                  type: SourceType.online,
                ).companion,
              ),
            ),
          );
        }
      },
    );
  }

  static QueryExecutor _openConnection() {
    if (true) {
      try {
        File(databaseFilepath).deleteSync();
      } catch (_) {}
    }
    return NativeDatabase.createInBackground(File(databaseFilepath));
  }
}
