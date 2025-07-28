import 'dart:io';
import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

Future performDelayedTap(BuildContext context, void Function() onTap) async {
  // Delay to show ripple-effect before executing the command
  await Future.delayed(const Duration(milliseconds: 150), () {
    if (context.mounted) onTap.call();
  });
}

bool isDesktop() {
  return Platform.isLinux || Platform.isWindows || Platform.isMacOS;
}

bool isMobile() {
  return Platform.isAndroid || Platform.isIOS;
}

String permissionToShortcut(String permission) {
  return permission
      .split(".")
      .last
      .split("_")
      .map((p) => p.substring(0, 1))
      .join();
}

Future sleepSec(int seconds) {
  return sleep(Duration(seconds: seconds));
}

Future sleep(Duration duration) {
  return Future.delayed(duration);
}

bool isSubtype<S, T>() => <S>[] is List<T>;
bool isNullableSubtype<S, T>() => <S>[] is List<T> || <S>[] is List<T?>;

int compareHostnames(String a, String b) {
  var aParts = a.split(".").reversed.toList();
  var bParts = b.split(".").reversed.toList();
  for (int i = 0; i < min(aParts.length, bParts.length); i++) {
    int cmp = aParts[i].compareTo(bParts[i]);
    if (cmp != 0) return cmp;
  }
  return a.length.compareTo(b.length);
}
int compareIPs(String a, String b) {
  bool aV6 = a.contains(":");
  bool bV6 = b.contains(":");
  if(aV6 != bV6){
    return aV6.compareTo(bV6);
  }
  var aParts = a.split(aV6 ? ":" : ".").toList();
  var bParts = b.split(bV6 ? ":" : ".").toList();
  for (int i = 0; i < min(aParts.length, bParts.length); i++) {
    int cmp = aParts[i].compareTo(bParts[i]);
    if (cmp != 0) return cmp;
  }
  return a.length.compareTo(b.length);
}
