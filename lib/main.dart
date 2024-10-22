import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/SplashScreen/splashView.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
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
  BackgroundFetch.configure(
    BackgroundFetchConfig(
      minimumFetchInterval: 15,
      startOnBoot: true,
      forceAlarmManager: true,
      stopOnTerminate: false,
      enableHeadless: true,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresStorageNotLow: false,
      requiresDeviceIdle: false,
      // requiresNetworkType: NetworkType.NONE,
    ),
    _backgroundFetchHandler,
  ).then((int status) {
    print('[BackgroundFetch] configure success: $status');
  }).catchError((e) {
    print('[BackgroundFetch] configure ERROR: $e');
  });

  // Register the headless task
  BackgroundFetch.registerHeadlessTask(myBackgroundFetchHeadlessTask);
}
// This is the background fetch handler that runs when the app is active or in the background.
void _backgroundFetchHandler(String taskId) async {
  print("[BackgroundFetch] Background task: $taskId");

  // Directly simulate a fetch operation and show a notification
  await fetchPrayerTimeData();

  // Finish the background task
  BackgroundFetch.finish(taskId);
}
// This is the headless task that runs when the app is terminated.
void myBackgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  // AwesomeNotificationService().showNotification(title: "Prayer Time Fetched", body: UserData().getUserData!.name.toString(), channelKey: 'important_channel');
  // AwesomeNotifications().createNotification(
  //   content: NotificationContent(
  //     id: 1,
  //     channelKey: 'important_channel',
  //     title: "Prayer Time Fetched",
  //     body: UserData().getUserData!.name.toString(),
  //   ),
  // );
  if (isTimeout) {
    print("[BackgroundFetch] Headless TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }

  print("[BackgroundFetch] Headless task: $taskId - Running in background or terminated state.");

  // Fetch prayer time or perform any necessary background task
  await fetchPrayerTimeData();

  BackgroundFetch.finish(taskId);
}

// Function to fetch prayer time data and show a notification
Future<void> fetchPrayerTimeData() async {
  try {
    // Dummy coordinates for the example
    double latitude = 23.8103;
    double longitude = 90.4125;
    int method = 2; // Replace with the actual prayer calculation method

    Uri uri = Uri.https(
      'api.aladhan.com',
      '/v1/calendar',
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'method': method.toString(),
      },
    );

    // final response = await http.get(uri);
    // AwesomeNotificationService().showNotification(title: "Api Prayer Time Fetched", body: UserData().getUserData!.name.toString(), channelKey: 'important_channel');
    // if (response.statusCode == 200) {
    //   print("API Response: ${response.body}");
    //
    //   // Display notification when prayer time data is successfully fetched
    //   AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: 1,
    //       channelKey: 'important_channel',
    //       title: "Prayer Time Fetched",
    //       body: "Prayer times have been updated successfully.",
    //     ),
    //   );
    // } else {
    //   print("Error fetching prayer times. Status Code: ${response.statusCode}");
    // }
  } catch (e) {
    print('Error fetching prayer time: $e');
  }
}

// void myBackgroundFetchHeadlessTask(HeadlessTask task) async {
//   String taskId = task.taskId;
//   bool isTimeout = task.timeout;
//
//   if (isTimeout) {
//     print("[BackgroundFetch] Headless TIMEOUT: $taskId");
//     BackgroundFetch.finish(taskId);
//     return;
//   }
//
//   print("[BackgroundFetch] Headless task: $taskId - Running in background or terminated state.");
//
//   // Example task logic:
//   DashBoardController dashboardController = DashBoardController();
//   await dashboardController.fetchPrayerTime();
//   dashboardController.startRemainingTimeTimer();
//
//   BackgroundFetch.finish(taskId);
// }

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

