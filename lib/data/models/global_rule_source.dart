enum SourceType { online, local }

class GlobalRuleSource {
  GlobalRuleSource({this.source = "", required this.type, this.contentHash});
  String source;
  SourceType type;
  String? contentHash;
  // TODO: store content hash and last access time to update only changed files (?)
}
