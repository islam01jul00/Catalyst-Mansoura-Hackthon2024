import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdg_app/core/utils/colors/dark_colors.dart';

class DarkMode {
  static ThemeData get() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: DarkColorManager.primaryColor,
    );
  }

  void setDarkThemeSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 0, 1, 3),
      systemNavigationBarColor: DarkColorManager.primaryColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }
}
