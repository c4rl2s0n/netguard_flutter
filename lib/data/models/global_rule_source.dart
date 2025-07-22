enum SourceType { online, local }

class GlobalRuleSource {
  GlobalRuleSource({this.source = "", required this.type});
  String source;
  SourceType type;
  // TODO: store content hash and last access time to update only changed files (?)
}
