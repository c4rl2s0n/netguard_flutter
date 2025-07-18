
enum SourceType{
  online, local
}
class GlobalRuleSource {
  GlobalRuleSource({this.source = "", required this.type});
  String source;
  SourceType type;
}
