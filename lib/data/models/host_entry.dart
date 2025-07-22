enum HostType { host, ip }

class HostEntry {
  HostEntry({
    this.ruleId,
    required this.target,
    required this.type,
    this.source,
  });
  String? ruleId;
  String target;
  HostType type;
  String? source;
}
