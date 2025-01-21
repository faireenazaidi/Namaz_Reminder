import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Widget/appColor.dart';

class ThemeController extends GetxController {
  // Observable for dark mode
  final RxBool isDarkMode = false.obs;

  // Toggles the theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  // Get the current ThemeMode
  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  // Update System UI Overlay Style based on theme
  void updateSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(

      isDarkMode.value
          ? const SystemUiOverlayStyle(

        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      )
          :  SystemUiOverlayStyle(
        statusBarColor: AppColor.cream,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}