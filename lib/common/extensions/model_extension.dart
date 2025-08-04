import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

extension ApplicationExtension on Application? {
  Widget get image => SizedBox.square(
    dimension: ThemeConstants.appIconSize,
    child: this != null && this!.icon != null
        ? Image.memory(this!.icon!)
        : Icon(CustomIcons.question),
  );
  String get label => this?.label ?? "Unknown";
}
