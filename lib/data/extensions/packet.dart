import 'package:netguard/common/common.dart';

extension PacketExtension on Packet {
  String get string => "uid=$uid v$version p$protocol $daddr/$dport";
}
