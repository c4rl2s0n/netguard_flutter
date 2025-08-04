import 'package:flutter/material.dart';

class ThemeConstants {
  static const Radius roundedCornerRadius = Radius.circular(12);
  static const BorderRadius borderRadius = BorderRadius.all(
    roundedCornerRadius,
  );
  static const double largeSpacing = 16;
  static const double spacing = 12;
  static const double smallSpacing = 6;
  static const double infoContainerActionButtonPadding = 2;
  static const double lightColorOpacity = 0.3;
  static int get lightColorOpacityAlpha => opacityToAlpha(lightColorOpacity);
  static const double mediumColorOpacity = 0.5;
  static int get mediumColorOpacityAlpha => opacityToAlpha(mediumColorOpacity);
  static const double strongColorOpacity = 0.7;
  static int get strongColorOpacityAlpha => opacityToAlpha(strongColorOpacity);
  static const double statusMarkerSize = 20;
  static const double listTileHeight = 60;
  static const double listTileImageMargin = 10;
  static const double scrollbarThickness = 10;
  static const double dividerHeight = 5;
  static const double appIconSize = 26;


  static int opacityToAlpha(double o) {
    if (o < 0) o = 0;
    if (o > 1) o = 1;
    return (255 * o).toInt();
  }
}
