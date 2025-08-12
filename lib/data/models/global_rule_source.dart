import 'package:netguard/common/common.dart';

enum SourceType { online, local }

class GlobalRuleSource {
  GlobalRuleSource({
    required this.id,
    this.source = "",
    required this.type,
    this.contentHash,
  });
  factory GlobalRuleSource.create({
    required String source,
    required SourceType type,
  }) =>
      GlobalRuleSource(id: IdTools.generateUuid(), source: source, type: type);
  String id;
  String source;
  SourceType type;
  String? contentHash;
  // TODO: store content hash and last access time to update only changed files (?)
}
