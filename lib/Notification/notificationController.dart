// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../Services/user_data.dart';
// import 'notificationDataModal.dart';
//
// class NotificationController extends GetxController {
//   var notificationsToday = <NotificationItem>[].obs;
//   var notificationsYesterday = <NotificationItem>[].obs;
//   var notificationsLast7Days = <NotificationItem>[].obs;
//   UserData userData = UserData();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchNotifications();
//   }
//
//   void fetchNotifications() async {
//     final url =
//         'http://182.156.200.177:8011/adhanapi/user_notifications/${userData.getUserData!.id}/';
//     print('API URL: $url');
//
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         print('API Response: ${response.body}');
//         final data = jsonDecode(response.body);
//         print("api rssss"+data.toString());
//         print(notificationsToday);
//         for (var item in data) {
//           final notification = NotificationItem.fromJson(item);
//           if (notification.category == "Today") {
//             notificationsToday.add(notification);
//           } else if (notification.category == "Yesterday") {
//             notificationsYesterday.add(notification);
//           } else if (notification.category == "Last7Days") {
//             notificationsLast7Days.add(notification);
//           }
//         }
//       } else {
//         print('Failed to fetch notifications. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching notifications: $e');
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Services/user_data.dart';

class NotificationController extends GetxController {
  // Private variables
  final RxList _notifications = [].obs;
  final RxList _todayNotifications = [].obs;
  final RxList _yesterdayNotifications = [].obs;
  final RxList _last7DaysNotifications = [].obs;
  UserData userData = UserData();
  // Getters
  List get notifications => _notifications;
  List get todayNotifications => _todayNotifications;
  List get yesterdayNotifications => _yesterdayNotifications;
  List get last7DaysNotifications => _last7DaysNotifications;

  // Setter for notifications
  set notifications(List value) {
    _notifications.value = value;
    _categorizeNotifications(); // Automatically categorize when setting new data
  }
  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }
  // Fetch notifications from API
  Future<void> fetchNotifications() async {
    final url = Uri.parse('http://182.156.200.177:8011/adhanapi/user_notifications/${userData.getUserData!.id}/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
     print('API Response: ${response.body}');

     final data = jsonDecode(response.body);
       print("api rssss"+data.toString());

      // Sort by date in descending order before setting notifications
      data.sort((a, b) {
        var dateA = DateTime.parse(a['created_at']);
        var dateB = DateTime.parse(b['created_at']);
        return dateB.compareTo(dateA);
      });

      // Update the notifications using the setter
      notifications = data;
    } else {
      // Get.snackbar('Error', 'Failed to load notifications');
    }
  }

  // Categorize notifications into Today, Yesterday, and Last 7 Days
  void _categorizeNotifications() {
    var today = DateTime.now();
    var yesterday = today.subtract(Duration(days: 1));
    var last7DaysStart = today.subtract(Duration(days: 7));

    _todayNotifications.clear();
    _yesterdayNotifications.clear();
    _last7DaysNotifications.clear();

    for (var notification in _notifications) {
      var notificationDate = DateTime.parse(notification['created_at']);
      if (_isSameDay(today, notificationDate)) {
        _todayNotifications.add(notification);
      } else if (_isSameDay(yesterday, notificationDate)) {
        _yesterdayNotifications.add(notification);
      } else if (notificationDate.isAfter(last7DaysStart)) {
        _last7DaysNotifications.add(notification);
      }
    }
  }

  // Helper method to compare dates
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}