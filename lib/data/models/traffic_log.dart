import 'package:netguard/common/native/native_bridge.g.dart' as native;

extension TrafficLogExtension on native.TrafficLog{
  String get destination => host ?? ip;
}