import 'dart:collection';
import 'dart:convert';

import 'package:netguard/common/extensions/extensions.dart';

import '../../../data/models/rule.dart';

class HostsParsingResult {
  HostsParsingResult({required this.hosts, required this.ips});
  HostsParsingResult.empty() : this(hosts: HashSet(), ips: HashSet());
  Set<String> hosts;
  Set<String> ips;
}

class ParsingTools {
  static const String ipv4Pattern =
      r"\b(?:(?:25[0-5]|2[0-4]\d|1?\d{1,2})\.){3}(?:25[0-5]|2[0-4]\d|1?\d{1,2})\b";
  static const String ipv6Pattern =
      r"\b(?:(?:[A-Fa-f0-9]{1,4}:){1,7}:|:(:[A-Fa-f0-9]{1,4}){1,7}|(?:[A-Fa-f0-9]{1,4}:){1,6}:[A-Fa-f0-9]{1,4})\b";

  // list of some ips found in hostsfiles that we want to ignore
  static const List<String> _ignoreIps = [
    "0.0.0.0",
    "127.0.0.1",
    "255.255.255.255",
    "::1",
    "fe80::1%lo0",
    "ff00::0",
    "ff00::0",
    "ff02::1",
    "ff02::2",
    "ff02::3",
  ];

  static HostsParsingResult parseHosts(
    String source, {
    HostsParsingResult? result,
  }) {
    result ??= HostsParsingResult.empty();
    for (var line in source.split("\n")) {
      int hashtag = line.indexOf("#");
      if (hashtag >= 0) line = line.substring(0, hashtag);

      // skip line if is only comment or empty
      if (line.isEmpty) continue;

      _parseLineForHosts(line, result);
      _parseLineForIPs(line, result);
    }
    return result;
  }

  static void _parseLineForHosts(String line, HostsParsingResult result) {
    List<String> parts = line.split(RegExp(r"\s+"));
    if (parts.isEmpty) return;
    String host = "";
    if (!parts.first.matchAny([ipv4Pattern, ipv6Pattern]) && parts.length > 1) {
      // if the first entry in the line is not an IP, we treat it as an host
      host = parts[1];
    } else if (parts.length == 2) {
      // if first part is IP, we take the second part (if available) as host
      host = parts[1];
    }
    if (host.notEmpty) result.hosts.add(host);
  }

  static void _parseLineForIPs(String line, HostsParsingResult result) {
    List<RegExpMatch> matches = [
      ...RegExp(ipv4Pattern).allMatches(line),
      ...RegExp(ipv6Pattern).allMatches(line),
    ];

    Iterable<String> ips = matches
        .map((m) => m.group(0))
        .nonNulls
        .where((s) => s.notEmpty);
    result.ips.addAll(ips);
  }

  static List<Rule> parseRules(String rulesRaw) {
    return _parseJsonToList<Rule>(rulesRaw, (m) => Rule.fromJson(m));
  }

  static List<T> _parseJsonToList<T>(
    String jsonString,
    T Function(Map<String, dynamic>) jsonToModel,
  ) {
    List<T> results = [];
    void parseToResults(Map<String, dynamic> json){
      try {
        results.add(jsonToModel(json));
      } catch (_) {}
    }
    final decoded = json.decode(jsonString);

    if (decoded is List) {
      // JSON string is a list of objects
      for (var json in decoded) {
        parseToResults(json as Map<String, dynamic>);
      }
    } else if (decoded is Map<String, dynamic>) {
      // JSON string is a single object
      parseToResults(decoded);
    }
    return results;
  }
}
