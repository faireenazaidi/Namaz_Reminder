import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AwesomeNotificationService {
  // Singleton setup
  static final AwesomeNotificationService _instance = AwesomeNotificationService._internal();
  factory AwesomeNotificationService() => _instance;
  AwesomeNotificationService._internal();


  /// Initialize Awesome Notifications
  Future<void> initialize() async {
    // Request schedule exact alarm permission for Android 13 and above
    await _requestExactAlarmPermission();
    AwesomeNotifications().initialize(
      null, // Use the default app icon
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          // soundSource: 'resource://raw/basic_tone', // Custom sound
        ),
        NotificationChannel(
          channelKey: 'important_channel',
          channelName: 'Important notifications',
          channelDescription: 'Notification channel for important notifications',
          defaultColor: const Color(0xFFFF0000),
          ledColor: Colors.red,
          importance: NotificationImportance.Max,playSound: true,defaultRingtoneType: DefaultRingtoneType.Notification,
          soundSource: 'resource://raw/important_tone',criticalAlerts: true, // Custom sound
        ),
        NotificationChannel(
          channelKey: 'urgent_channel',
          channelName: 'Urgent notifications',
          channelDescription: 'Notification channel for urgent notifications',
          defaultColor: const Color(0xFF0000FF),
          ledColor: Colors.blue,
          importance: NotificationImportance.High,
          // soundSource: 'resource://raw/urgent_tone', // Custom sound
        ),
      ],
      debug: true,
    );
  }

  /// Request exact alarm permission for Android 13 (API level 33) and above
  Future<void> _requestExactAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  /// Show Awesome Notification
  Future<void> showNotification({
    required String? title,
    required String? body,
    required String channelKey,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: channelKey,
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
        criticalAlert: true,
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true
      ),
    );
  }
}
