import 'package:netguard/native_bridge.g.dart';

extension PacketExtension on Packet{
  String get string => "uid=$uid v$version p$protocol $daddr/$dport";
}