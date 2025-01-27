import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Widget/appColor.dart';

// class ThemeController extends GetxController {
//   // Observable for dark mode
//   final RxBool isDarkMode = false.obs;
//
//   // Toggles the theme
//   void toggleTheme() {
//     isDarkMode.value = !isDarkMode.value;
//   }
//
//   // Get the current ThemeMode
//   ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
//
//   // Update System UI Overlay Style based on theme
//   void updateSystemUIOverlayStyle() {
//     SystemChrome.setSystemUIOverlayStyle(
//       isDarkMode.value
//           ?  SystemUiOverlayStyle(
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.dark,
//         systemNavigationBarColor: AppColor.cream,
//         systemNavigationBarIconBrightness: Brightness.light,
//         statusBarColor: Colors.red
//       )
//           : const SystemUiOverlayStyle(
//         statusBarColor: Colors.red      ,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.light,
//         systemNavigationBarColor: Colors.white,
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ),
//     );
//   }
//
// }
class ThemeController extends GetxController {
  final RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    updateSystemUIOverlayStyle();
  }

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void updateSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      isDarkMode.value
          ? SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColor.cream,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      )
          : SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    isDarkMode.listen((_) {
      updateSystemUIOverlayStyle();
    });
  }
}
