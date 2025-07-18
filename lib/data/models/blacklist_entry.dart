import 'package:netguard/data/data.dart';

class BlacklistEntry {
  BlacklistEntry({
    this.ruleId,
    required this.target,
    required this.type,
    this.source,
  });
  String? ruleId;
  String target;
  BlacklistType type;
  String? source;
}
