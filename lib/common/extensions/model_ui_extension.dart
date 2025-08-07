import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

extension ApplicationUiExtension on Application? {
  Widget get image => SizedBox.square(
    dimension: ThemeConstants.appIconSize,
    child: this != null && this!.icon != null
        ? Image.memory(this!.icon!)
        : Icon(CustomIcons.question),
  );
  Widget get wIcon => this != null && this!.icon != null
      ? Image.memory(this!.icon!)
      : Icon(CustomIcons.question);
}
