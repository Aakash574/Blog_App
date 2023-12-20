import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class ThemeConfig {
  static final darkTheme = ThemeData(
    // colorSchemeSeed: ConstColors.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ConstColors.primaryColor,
      brightness: Brightness.dark,
      background: ConstColors.primaryColor,
      // backgroundColor: ConstColors.primaryColor,
    ),
  );
}
