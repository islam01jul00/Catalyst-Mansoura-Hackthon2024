import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdg_app/core/utils/colors/light_colors.dart';

class LightMode {
  static ThemeData get() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: LightColorManager.whiteColor,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: LightColorManager.whiteColor,
          systemNavigationBarColor: LightColorManager.whiteColor,
        ),
      ),
    );
  }
}
