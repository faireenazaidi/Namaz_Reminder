import 'package:awesome_notifications/awesome_notifications.dart';
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
import 'Services/notification_service.dart';
import 'Services/user_data.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
void myBackgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;

  if (isTimeout) {
    print("[BackgroundFetch] Headless TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }

  print("[BackgroundFetch] Headless task: $taskId - Running in background or terminated state.");

  // Perform the background task (e.g., fetching prayer times, showing notifications)
  await fetchPrayerTimeData();

  // Finish the task after completing your work
  BackgroundFetch.finish(taskId);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessagingService firebaseMessagingService = FirebaseMessagingService();
  await firebaseMessagingService.initializeFirebaseMessaging();
  // await GetStorage.init();
  await GetStorage.init('user');
  // Get.put(DashBoardController());
  // Get.put(LoginController());
  // Get.put(CustomDrawerController());
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
      requiredNetworkType: NetworkType.ANY
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
  // _scheduleManualNotification('zohr');

  // Finish the background task
  BackgroundFetch.finish(taskId);
}
// This is the headless task that runs when the app is terminated.
// void myBackgroundFetchHeadlessTask(HeadlessTask task) async {
//   String taskId = task.taskId;
//   bool isTimeout = task.timeout;
//   AwesomeNotificationService().showNotification(title: "just enter Time Fetched", body: UserData().getUserData!.name.toString(), channelKey: 'important_channel');
//   // AwesomeNotifications().createNotification(
//   //   content: NotificationContent(
//   //     id: 1,
//   //     channelKey: 'important_channel',
//   //     title: "Prayer Time Fetched",
//   //     body: UserData().getUserData!.name.toString(),
//   //   ),
//   // );
//   await fetchPrayerTimeData();
//   if (isTimeout) {
//     print("[BackgroundFetch] Headless TIMEOUT: $taskId");
//     AwesomeNotificationService().showNotification(title: "time out", body: UserData().getUserData!.name.toString(), channelKey: 'important_channel');
//     BackgroundFetch.finish(taskId);
//     return;
//   }
//
//   print("[BackgroundFetch] Headless task: $taskId - Running in background or terminated state.");
//
//   // Fetch prayer time or perform any necessary background task
//   // await fetchPrayerTimeData();
//   // _scheduleManualNotification('zohr');
//   BackgroundFetch.finish(taskId);
// }

// Function to fetch prayer time data and show a notification
// Schedule a single notification using Awesome Notifications for testing
// void _scheduleManualNotification(String prayerName) {
//   // Schedule notification 2 minutes from now for testing
//   DateTime now = DateTime.now();
//   DateTime testScheduledTime = now.add(Duration(minutes: 5)); // Set time 2 minutes ahead
//
//   AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: prayerName.hashCode, // Unique ID for each prayer
//       channelKey: 'important_channel',
//       title: 'Test Prayer Time Alert',
//       body: '$prayerName time has been manually scheduled for testing.',
//       notificationLayout: NotificationLayout.Default,
//     ),
//     schedule: NotificationCalendar(
//       year: testScheduledTime.year,
//       month: testScheduledTime.month,
//       day: testScheduledTime.day,
//       hour: testScheduledTime.hour,
//       minute: testScheduledTime.minute,
//       second: 0,
//       millisecond: 0,
//       repeats: false,
//     ),
//   );
//
//   print("Manual notification for $prayerName scheduled at: $testScheduledTime");
// }

Future<void> fetchPrayerTimeData() async {
  // AwesomeNotificationService().showNotification(title: "Enter Api Prayer Time Fetched", body: "UserData().getUserData!.name.toString()", channelKey: 'important_channel');
  try {
    // Get today's date
    DateTime now = DateTime.now();
    String todayDate = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

    double latitude = 23.8103;
    double longitude = 90.4125;
    int method = 2; // Replace with the actual prayer calculation method
    // AwesomeNotificationService().showNotification(title: "Api run Prayer Time $todayDate", body: "UserData().getUserData!.name.toString()", channelKey: 'important_channel');
    // Uri uri = Uri.https(
    //   'api.aladhan.com',
    //   '/v1/calendar',
    //   {
    //     'latitude': latitude.toString(),
    //     'longitude': longitude.toString(),
    //     'method': method.toString(),
    //   },
    // );
    //
    // final response = await http.get(uri);
    List listData = [
    {
      "timings": {
  "Fajr": "04:51 (IST)",
  "Sunrise": "05:59 (IST)",
  "Dhuhr": "12:01 (IST)",
  "Asr": "12:30 (IST)",
  "Sunset": "17:53 (IST)",
  "Maghrib": "12:40 (IST)",
  "Isha": "21:00 (IST)",
  "Imsak": "04:41 (IST)",
  "Midnight": "23:56 (IST)",
  "Firstthird": "21:55 (IST)",
  "Lastthird": "01:57 (IST)"
},
  "date": {
  "readable": "01 Oct 2024",
  "timestamp": "1727753461",
  "gregorian": {
  "date": "05-11-2024",
  "format": "DD-MM-YYYY",
  "day": "01",
  "weekday": {
  "en": "Tuesday"
},
  "month": {
  "number": 10,
  "en": "October"
},
  "year": "2024",
  "designation": {
  "abbreviated": "AD",
  "expanded": "Anno Domini"
}
},
  "hijri": {
  "date": "27-03-1446",
  "format": "DD-MM-YYYY",
  "day": "27",
  "weekday": {
  "en": "Al Thalaata",
  "ar": "\u0627\u0644\u062b\u0644\u0627\u062b\u0627\u0621"
},
  "month": {
  "number": 3,
  "en": "Rab\u012b\u02bf al-awwal",
  "ar": "\u0631\u064e\u0628\u064a\u0639 \u0627\u0644\u0623\u0648\u0651\u0644"
},
  "year": "1446",
  "designation": {
  "abbreviated": "AH",
  "expanded": "Anno Hegirae"
},
  "holidays": []
}
},
  "meta": {
  "latitude": 1.234567,
  "longitude": 2.34567,
  "timezone": "Asia\/Kolkata",
  "method": {
  "id": 0,
  "name": "Shia Ithna-Ashari, Leva Institute, Qum",
  "params": {
  "Fajr": 16,
  "Isha": 14,
  "Maghrib": 4,
  "Midnight": "JAFARI"
},
  "location": {
  "latitude": 34.6415764,
  "longitude": 50.8746035
}
},
  "latitudeAdjustmentMethod": "ANGLE_BASED",
  "midnightMode": "STANDARD",
  "school": "STANDARD",
  "offset": {
  "Imsak": 0,
  "Fajr": 0,
  "Sunrise": 0,
  "Dhuhr": 0,
  "Asr": 0,
  "Maghrib": 0,
  "Sunset": 0,
  "Isha": 0,
  "Midnight": 0
}
}
},

  ];

    // Extract today’s prayer timings from your list data
    var todayPrayerData = listData.firstWhere((data) => data['date']['gregorian']['date'] == todayDate, orElse: () => null);

    if (todayPrayerData != null) {
      var timings = todayPrayerData['timings'];
      schedulePrayerNotifications(timings);
    } else {
      print("No prayer data available for today's date.");
    }
  } catch (e) {
    print('Error fetching prayer time: $e');
  }
}

// Function to schedule notifications for prayer times
void schedulePrayerNotifications(Map<String, String> timings) {
  DateTime now = DateTime.now();
  DateTime endDate = now.add(Duration(days: 7));
  List<String> prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

  for (String prayer in prayers) {
    String timing = timings[prayer]!;
    DateTime prayerTime = _convertToDateTime(timing);

    // Schedule once per day for the next week
    while (prayerTime.isBefore(endDate)) {
      if (prayerTime.isAfter(now)) {
        _scheduleAwesomeNotification(prayer, prayerTime);
        print('Scheduled $prayer notification for $prayerTime');
      }

      // Move to the next day's prayer time
      prayerTime = prayerTime.add(Duration(days: 1));
    }
  }
}

// void schedulePrayerNotifications(Map<String, String> timings) {
//   // Get the current date and time
//   DateTime now = DateTime.now();
//
//   // List of prayer times to schedule
//   List<String> prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
//
//   // Schedule notifications for each prayer time
//   for (String prayer in prayers) {
//     String timing = timings[prayer]!;
//     DateTime scheduledTime = _convertToDateTime(timing);
//
//     // Calculate the next occurrence of the prayer time
//     while (scheduledTime.isBefore(now.add(Duration(days: 7)))) {
//       scheduledTime = scheduledTime.add(Duration(minutes: 10));
//       print('ffffffffffffff');
//     }
//
//     // Schedule the notification
//     _scheduleAwesomeNotification(prayer, scheduledTime);
//   }
// }
// Convert time string to DateTime object
DateTime _convertToDateTime(String timing) {
  // Remove the "(IST)" part and parse the time
  timing = timing.split(" ")[0];
  int hour = int.parse(timing.split(":")[0]);
  int minute = int.parse(timing.split(":")[1]);

  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day, hour, minute);
}

// Schedule a single notification using Awesome Notifications
void _scheduleAwesomeNotification(String prayerName, DateTime scheduledTime) {
  AwesomeNotifications().createNotification(

    content: NotificationContent(
      id: prayerName.hashCode + scheduledTime.hashCode,
      channelKey: 'important_channel',
      title: '$prayerName Prayer Reminder',
      body: 'It\'s time for $prayerName prayer!',
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar(
      year: scheduledTime.year,
      month: scheduledTime.month,
      day: scheduledTime.day,
      hour: scheduledTime.hour,
      minute: scheduledTime.minute,
      second: 0,
      millisecond: 0,
      repeats: false,
    ),
  );
}

// Future<void> fetchPrayerTimeData() async {
//   try {
//     // Dummy coordinates for the example
//     double latitude = 23.8103;
//     double longitude = 90.4125;
//     int method = 2; // Replace with the actual prayer calculation method
//
//     Uri uri = Uri.https(
//       'api.aladhan.com',
//       '/v1/calendar',
//       {
//         'latitude': latitude.toString(),
//         'longitude': longitude.toString(),
//         'method': method.toString(),
//       },
//     );
//
//     // final response = await http.get(uri);
//     AwesomeNotificationService().showNotification(title: "Api Prayer Time Fetched", body: UserData().getUserData!.name.toString(), channelKey: 'important_channel');
//     // if (response.statusCode == 200) {
//     //   print("API Response: ${response.body}");
//     //
//     //   // Display notification when prayer time data is successfully fetched
//     //   AwesomeNotifications().createNotification(
//     //     content: NotificationContent(
//     //       id: 1,
//     //       channelKey: 'important_channel',
//     //       title: "Prayer Time Fetched",
//     //       body: "Prayer times have been updated successfully.",
//     //     ),
//     //   );
//     // } else {
//     //   print("Error fetching prayer times. Status Code: ${response.statusCode}");
//     // }
//   } catch (e) {
//     print('Error fetching prayer time: $e');
//   }
// }

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
    // final userDataController = Get.find<LoginController>();
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
        // home: SplashScreen(),
      );
    });
  }
}

