import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Widget/appColor.dart';

class AppThemes {
  static ThemeData get lightTheme {
    return ThemeData(

      dividerColor: AppColor.packageGray,
      brightness: Brightness.light,
      primaryColor: AppColor.lightmustard,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme:  AppBarTheme(
        backgroundColor: AppColor.lightmustard,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        surfaceTintColor: AppColor.lightmustard,
      ),
      textTheme:  TextTheme(
        displaySmall: TextStyle(color: AppColor.black),
        bodySmall: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black87),
        titleSmall: TextStyle(color: AppColor.greyColor),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(

      dividerColor: Colors.white24,
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: AppColor.scaffBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      textTheme:  TextTheme(
        displaySmall: TextStyle(color: AppColor.circleIndicator),
        titleSmall: const TextStyle(color: AppColor.greyColor),
        bodyLarge: const TextStyle(color: Colors.white),
        bodyMedium: const TextStyle(color: Colors.white70),
        bodySmall: const TextStyle(color: Colors.black),
        titleLarge: const TextStyle(color: Colors.white),
        titleMedium: const TextStyle(color: Colors.white70),

      ),
      colorScheme:  ColorScheme.dark(
        primary: Colors.transparent,
        onPrimary: AppColor.searchbg,
        surface: Colors.black,
        onSurface: Colors.white,

      ),
    );
  }
}
