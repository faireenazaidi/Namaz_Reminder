import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:namaz_reminders/DashBoard/dashboardController.dart';
import 'package:namaz_reminders/DashBoard/dashboardView.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageView.dart';
import 'package:namaz_reminders/Login/loginView.dart';
import 'LocationSelectionPage/locationPageController.dart';
import 'Login/loginController.dart';
import 'Routes/approutes.dart';
import 'SplashScreen/splashView.dart';
import 'firebase_options.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  await GetStorage.init('user');

  Get.put(LocationPageController());

  Get.put(DashBoardController());
  Get.put(LoginController());
  Get.put(CustomDrawerController());
  runApp(MyApp());
}
// void main() async {
//   Get.put(LocationPageController());
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     // options: DefaultFirebaseOptions.currentPlatform,
//   );
//   Get.put(DashBoardController());
//   Get.put(LoginController());
//   Get.put(CustomDrawerController());
//   runApp( MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CustomDrawerController customDrawerController = Get.put(CustomDrawerController());
    return Obx(() {
      return GetMaterialApp(
        initialRoute: AppRoutes.splashRoute,
        getPages: AppRoutes.pages,
        debugShowCheckedModeBanner: false,
        title: 'Namaz Reminders',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: customDrawerController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        home: SplashScreen(),
      );
    });
  }
}

