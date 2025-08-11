import 'package:flutter/material.dart';
import 'package:netguard/common/native/flutter_headless.dart';
import 'package:netguard/features/splash_screen/splash_screen.dart';

void main() {
  runApp(const SplashScreen());
}


@pragma('vm:entry-point')
void headlessEntryPoint() {
  FlutterHeadless().run();
}