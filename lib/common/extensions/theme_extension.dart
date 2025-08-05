import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';

extension ThemeDataExtension on ThemeData {}

extension NullableTextStyleExtension on TextStyle? {
  TextStyle? withOpacity(double opacity) =>
      this?.copyWith(color: this?.color?.withOpacity(opacity));
  TextStyle? withColor(Color? color) => this?.copyWith(color: color);
  double? get size {
    return this?.fontSize == null
        ? null
        : (this!.fontSize! * (this?.height ?? 1));
  }
}

extension IconThemeExtension on IconThemeData? {
  IconThemeData? withOpacity(double opacity) =>
      this?.copyWith(color: this?.color?.withOpacity(opacity));
  IconThemeData? withColor(Color? color) => this?.copyWith(color: color);
}


extension ColorExtension on Color{
  Color get light => withAlpha(ThemeConstants.lightColorOpacityAlpha);
  Color get medium => withAlpha(ThemeConstants.mediumColorOpacityAlpha);
  Color get strong => withAlpha(ThemeConstants.strongColorOpacityAlpha);
}
