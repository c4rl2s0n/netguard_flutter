// In your Dart code (Flutter)
import 'package:flutter/services.dart';

class VpnEventChannel {
  static const EventChannel _channel = EventChannel('netguard/vpn_events');

  static Stream<dynamic> get stream => _channel.receiveBroadcastStream();
}