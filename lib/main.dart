import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/Feedback/feedbackView.dart';
import 'package:namaz_reminders/Notification/notificationView.dart';
import 'package:namaz_reminders/SplashScreen/splashView.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'AppTranslation/apptrans.dart';
import 'Login/loginController.dart';
import 'Routes/approutes.dart';
import 'Services/firebase_services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessagingService firebaseMessagingService = FirebaseMessagingService();
  await firebaseMessagingService.initializeFirebaseMessaging();
  await GetStorage.init();
  await GetStorage.init('user');
  // Get.put(DashBoardController());
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
    final userDataController = Get.find<LoginController>();
    return Obx(() {
      return GetMaterialApp(
        theme: ThemeData(
            appBarTheme:AppBarTheme(
            surfaceTintColor: AppColor.lightmustard
            ),
            useMaterial3: true),
        initialRoute: AppRoutes.splashRoute,
        getPages: AppRoutes.pages,
        debugShowCheckedModeBanner: false,
        title: 'Namaz Reminders',
        // translations: AppTranslation(),  // Translation class
        // locale: userDataController.getLangCode == ""
        //     ? Get.deviceLocale  // Default to device locale if no language is set
        //     : Locale(userDataController.getLangCode),  // Use stored language code
        fallbackLocale: const Locale('en', 'US'),  // Fallback language if not available
        darkTheme: ThemeData.dark(),
        themeMode: customDrawerController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        home: SplashScreen(),
      );
    });
  }
}

