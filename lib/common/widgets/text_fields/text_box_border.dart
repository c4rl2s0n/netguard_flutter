import 'package:flutter/material.dart';

import 'package:netguard/common/common.dart';

InputBorder getTextBoxBorder(BuildContext context) {
  return UnderlineInputBorder(
    borderSide: BorderSide(color: context.colors.onBackground, width: 1),
    //borderRadius: BorderRadius.all(ThemeConstants.roundedCornerRadius),
  );
}

InputBorder getErrorTextBoxBorder(BuildContext context) {
  InputBorder tbb = getTextBoxBorder(context);
  return tbb.copyWith(
    borderSide: tbb.borderSide.copyWith(color: context.colors.negative),
  );
}
