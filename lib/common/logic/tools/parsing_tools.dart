import 'package:netguard/common/extensions/extensions.dart';

class HostsParsingResult {
  HostsParsingResult({required this.hosts, required this.ips});
  List<String> hosts;
  List<String> ips;
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

  static HostsParsingResult parseHosts(String source) {
    HostsParsingResult result = HostsParsingResult(hosts: [], ips: []);
    for (var line in source.split("\n")) {
      int hashtag = line.indexOf("#");
      if (hashtag >= 0) line = line.substring(0, hashtag);

      // skip line if is only comment or empty
      if (line.isEmpty) continue;

      _parseLineForHosts(line, result);
      _parseLineForIPs(line, result);
    }
    result.hosts = result.hosts.distinct;
    result.ips = result.ips.distinct;
    return result;
  }

  static void _parseLineForHosts(String line, HostsParsingResult result) {
    List<String> parts = line.split(RegExp(r"\s+"));
    if (parts.isEmpty) return;
    if (!parts.first.matchAny([ipv4Pattern, ipv6Pattern]) && parts.length > 1) {
      // if the first entry in the line is not an IP, we treat it as an host
      result.hosts.add(parts[1]);
    } else if (parts.length == 2) {
      // if first part is IP, we take the second part (if available) as host
      result.hosts.add(parts[1]);
    }
  }

  static void _parseLineForIPs(String line, HostsParsingResult result) {
    List<RegExpMatch> matches = [
      ...RegExp(ipv4Pattern).allMatches(line),
      ...RegExp(ipv6Pattern).allMatches(line),
    ];

    // TODO: check performance if it is better to check for existence this here or do .distinct later...
    // Iterable<String> ips = matches.map((m) => m.group(0)).nonNulls.where((s) => !result.ips.contains(s));
    Iterable<String> ips = matches
        .map((m) => m.group(0))
        .nonNulls
        .where((s) => !_ignoreIps.contains(s));
    result.ips.addAll(ips);
  }
}
