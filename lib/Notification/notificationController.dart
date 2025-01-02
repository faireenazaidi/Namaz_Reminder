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
import '../PeerCircle/AddFriends/AddFriendDataModal.dart';
import '../PeerCircle/peerController.dart';
import '../Services/ApiService/api_service.dart';
import '../Services/user_data.dart';

class NotificationController extends GetxController {
  final PeerController peerController = Get.put(PeerController());

  // Private variables
  final RxList _notifications = [].obs;
  final RxList _todayNotifications = [].obs;
  final RxList _yesterdayNotifications = [].obs;
  final RxList _last7DaysNotifications = [].obs;
  var isLoading = true.obs;
  UserData userData = UserData();
  final apiService = ApiService();

  // Getters
  List get notifications => _notifications;
  // List<NotificationDataModal> get getNotifications => List<NotificationDataModal>.from(_notifications.map((e) => NotificationDataModal.fromJson(e)).toList());


  List get todayNotifications => _todayNotifications;

  List get yesterdayNotifications => _yesterdayNotifications;

  List get last7DaysNotifications => _last7DaysNotifications;

  // Setter for notifications
  set notifications(List value) {
    _notifications.value = value;
    _categorizeNotifications();
  }

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  // Fetch notifications from API
  Future<void> fetchNotifications() async {
    // final url = Uri.parse('http://182.156.200.177:8011/adhanapi/user_notifications/${userData.getUserData!.id}/');
    final url = Uri.parse('http://182.156.200.177:8011/adhanapi/user_notifications/${userData.getUserData!.id}/');
    final response = await http.get(url);
    isLoading.value = false;
    if (response.statusCode == 200) {
      print('ResponseAPI : ${response.body}');

      final data = jsonDecode(response.body);
      print("api rssss" + data.toString());

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

  // Method to mark notification as read
  // void markAsRead(String notificationId) {
  // var notification = notifications.firstWhere((n) => n['id'] == notificationId);
  // if (notification != null) {
  // notification['is_read'] = true;
  // update();
  // }
  // }


  String buildFullImageUrl(String? imagePath) {
    const String baseUrl = "http://182.156.200.177:8011";
    if (imagePath == null || imagePath.startsWith('http')) {
      return imagePath ?? '';
    }
    return baseUrl + imagePath;
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

  // List friendRequestList = [];
  //
  // List<FriendRequestDataModal> get getFriendRequestList =>
  //     List<FriendRequestDataModal>.from(
  //         friendRequestList.map((element) =>
  //             FriendRequestDataModal.fromJson(element)).toList());
  //
  // set updateFriendRequestList(List val) {
  //   friendRequestList = val;
  //   update();
  // }
  ///ACCEPT REQUEST
  // acceptFriendRequest(String id) async {
  //   var headers = {
  //     'Content-Type': 'application/json'
  //   };
  //   var request = http.Request(
  //       'POST', Uri.parse('http://182.156.200.177:8011/adhanapi/accept-friend-request/'));
  //
  //   String userId = userData.getUserData?.id.toString() ?? "";
  //   //print("Sending Request ID: $id");
  //   print("Sending User ID: $userId");
  //
  //   // if (id.isEmpty || userId.isEmpty) {
  //   //   print("Invalid data: requestId or userId is empty");
  //   //   return;
  //   // }
  //
  //   request.body = json.encode({
  //     "request_id":  id.toString(),
  //     "user_id": userId,
  //   });
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   var data = jsonDecode(await response.stream.bytesToString());
  //   print("Decoded Data: $data");
  //
  //   if (response.statusCode == 200) {
  //     print("Friend request accepted successfully.");
  //     update();
  //     peerController.friendship(); // Update the friend list
  //   } else {
  //     print("Unexpected response: $data");
  //   }
  // }
  acceptFriendRequest(NotificationDataModal notificationData) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    try {
      var request = http.Request('POST', Uri.parse(
          'http://182.156.200.177:8011/adhanapi/accept-friend-request/'));
      request.body = json.encode({
        "request_id": notificationData.userId.toString(),
        "user_id": userData.getUserData!.id.toString(),
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if(response.statusCode==200){
      var data = jsonDecode(await response.stream.bytesToString());
       print("Friend Request Accepted $data");
       notificationData.readStatus;
      _notifications.removeWhere((notification) => notification['id'] == notificationData.notificationId);
       update();
     }
      else {
        print("Failed to remove notification: ${response.reasonPhrase}");
      }
    }
    catch(ex){
      print("Error: $ex");
    }
  }
  ///DECLINE REQUEST
  declineRequest(NotificationDataModal notificationData) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    try{
    var request = http.Request('POST', Uri.parse(
        'http://182.156.200.177:8011/adhanapi/reject-friend-request/'));
    request.body = json.encode({
      "user_id": userData.getUserData!.id.toString(),
      "request_id": notificationData.userId.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if(response.statusCode==200) {
      var data = jsonDecode(await response.stream.bytesToString());
      print("Friend Request Decline $data");
      notificationData.readStatus = true;
      _notifications.removeWhere((notification) => notification['id'] == notificationData.notificationId);
    }
  }
    catch(ex) {
      print("Error: $ex");
    }
  }
  ///Remove Accepted and decline rqwst from view

  Future<void> removeNotification(int id, String type) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse('http://182.156.200.177:8011/adhanapi/user_notifications/'),
    );

    request.body = json.encode({
      "id": id,
      "type": "friend_request",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    // Log the response
    print("Remove Notification Response Status: ${response.statusCode}");
    print("Remove Notification Response Body: $responseBody");

    if (response.statusCode == 200) {
      print("Notification removed successfully.");
    } else {
      print("Failed to remove notification: ${response.reasonPhrase}");
    }
  }
  // Future<void> readNotificationMessage(NotificationDataModal notificationData) async {
  //   var headers = {'Content-Type': 'application/json'};
  //   final url = Uri.parse('http://182.156.200.177:8011/adhanapi/user_notifications/${userData.getUserData!.id}/');
  //
  //
  //   var request = http.Request('PUT', Uri.parse(url.toString()));
  //   request.body = json.encode({
  //     "id": notificationData.notificationId,
  //     "type": "friend_request_acc",
  //     "is_read":notificationData.readStatus,
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  //   // // Create the body for the request
  //   // final requestBody = json.encode({
  //   //   "id": notificationData.notificationId,
  //   //   "type": "friend_request_acc",
  //   //   "is_read": notificationData.readStatus,
  //   // });
  //   //
  //   // try {
  //   //   final response = await http.put(
  //   //     url,
  //   //     headers: headers,
  //   //     body: requestBody,
  //   //   );
  //
  //   //   if (response.statusCode == 200) {
  //   //
  //   //     print("Notification removed successfully.");
  //   //   } else {
  //   //     print("Failed to remove notification: ${response.reasonPhrase}");
  //   //   }
  //   // } catch (e) {
  //   //   print("Error: $e");
  //   // }
  // }


  readNotificationMessage(String notificationId) async{
    print("NotificationId"+notificationId);
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse('http://182.156.200.177:8011/adhanapi/user_notifications/${userData.getUserData!.id}/'));
    request.body = json.encode({
      "id": notificationId,
      "type": "friend_request_acc",
      "is_read": false
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }
}