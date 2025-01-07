import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../AppManager/dialogs.dart';
import '../DashBoard/dashboardController.dart';
import '../PeerCircle/AddFriends/AddFriendDataModal.dart';
import '../PeerCircle/peerController.dart';
import '../Services/ApiService/api_service.dart';
import '../Services/user_data.dart';
import '../Widget/no_internet.dart';
import '../main.dart';

class NotificationController extends GetxController {
  final DashBoardController dashBoardController = Get.find<DashBoardController>();

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
 //  Future<void> fetchNotifications() async {
 //    // final url = Uri.parse('http://182.156.200.177:8011/adhanapi/user_notifications/${userData.getUserData!.id}/');
 //    final url = Uri.parse('http://182.156.200.177:8011/adhanapi/user_notifications/${userData.getUserData!.id}/');
 //    final response = await http.get(url);
 //    isLoading.value = false;
 //    if (response.statusCode == 200) {
 //      print('ResponseAPI : ${response.body}');
 //
 //      final data = jsonDecode(response.body);
 //      print("api rssss" + data.toString());
 //
 //      // Sort by date in descending order before setting notifications
 //      data.sort((a, b) {
 //        var dateA = DateTime.parse(a['created_at']);
 //        var dateB = DateTime.parse(b['created_at']);
 //        return dateB.compareTo(dateA);
 //      });
 //      // Update the notifications using the setter
 //      notifications = data;
 //    } else {
 //      // Get.snackbar('Error', 'Failed to load notifications');
 //    }
 //  }

  // Future<void> fetchNotifications() async {
  //   isLoading.value = true;
  //   try {
  //     // Call the ApiService to fetch data
  //     final data = await ApiService().getRequest(
  //       'user_notifications/${userData.getUserData?.id}/',
  //     );
  //     print("APIIRes: $data");
  //     // Sort notifications by date in descending order
  //     data.sort((a, b) {
  //       DateTime dateA = DateTime.parse(a['created_at']);
  //       DateTime dateB = DateTime.parse(b['created_at']);
  //       return dateB.compareTo(dateA);
  //     });
  //     // Update notifications list
  //     notifications = data;
  //   } catch (e) {
  //     print('Error while fetching notifications: $e');
  //     print('$e');
  //     final context = navigatorKey.currentContext!;
  //     Dialogs.showCustomBottomSheet(context: context,
  //       content: NoInternet(message: '$e',
  //           onRetry: (){}),);
  //   } finally {
  //     isLoading.value = false; // Stop loading
  //   }
  // }
  Future<void> fetchNotifications() async  {
    isLoading.value = true;
    try {
      final data = await ApiService().getRequest(
        'user_notifications/${userData.getUserData?.id}/',
      );
      print("APIIRes: $data");
      data.sort((a, b) {
        DateTime dateA = DateTime.parse(a['created_at']);
        DateTime dateB = DateTime.parse(b['created_at']);

        return dateB.compareTo(dateA);

      });
      if (data.isNotEmpty) {
        DateTime latestDate = DateTime.parse(data.first['created_at']).toLocal();
        notifications = data.where((notification) {
          DateTime notificationDate = DateTime.parse(notification['created_at']).toLocal();
          return notificationDate.year == latestDate.year &&
              notificationDate.month == latestDate.month &&
              notificationDate.day == latestDate.day;
        }).toList();

        notifications = notifications.toSet().toList();
        print(notifications);
      }
      else
      {
        notifications = [];
      }
    }
    catch (e)
    {
      print('Error while fetching notifications: $e');
      final context = navigatorKey.currentContext!;
      Dialogs.showCustomBottomSheet(
        context: context,
        content: NoInternet(
          message: '$e',
          onRetry: () {},
        ),
      );
    }
    finally {
      isLoading.value = false;
    }
  }


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
  // acceptFriendRequest(NotificationDataModal notificationData) async {
  //   var headers = {
  //     'Content-Type': 'application/json'
  //   };
  //   try {
  //     var request = http.Request('POST', Uri.parse(
  //         'http://182.156.200.177:8011/adhanapi/accept-friend-request/'));
  //     request.body = json.encode({
  //       "request_id": notificationData.userId.toString(),
  //       "user_id": userData.getUserData!.id.toString(),
  //     });
  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();
  //
  //     if(response.statusCode==200){
  //     var data = jsonDecode(await response.stream.bytesToString());
  //      print("Friend Request Accepted $data");
  //      notificationData.readStatus;
  //     _notifications.removeWhere((notification) => notification['id'] == notificationData.notificationId);
  //      update();
  //    }
  //     else {
  //       print("Failed to remove notification: ${response.reasonPhrase}");
  //     }
  //   }
  //   catch(ex){
  //     print("Error: $ex");
  //   }
  // }
  Future<void> acceptFriendRequest(NotificationDataModal notificationData) async {
    try {
      final body = {
        "request_id": notificationData.userId.toString(),
        "user_id": userData.getUserData!.id.toString(),
      };
      final response = await ApiService().postRequest(
        'accept-friend-request/',
        body,
      );
      print("Friend Request Acceptedd: $response");

      _notifications.removeWhere(
            (notification) => notification['id'] == notificationData.notificationId,
      );
      update();
    } catch (ex) {
      print("Error accepting friend request: $ex");
    }
    dashBoardController.fetchMissedPrayersCount();
  }

  ///DECLINE REQUEST
  // declineRequest(NotificationDataModal notificationData) async {
  //   var headers = {
  //     'Content-Type': 'application/json'
  //   };
  //   try{
  //     var request = http.Request('POST', Uri.parse(
  //         'http://182.156.200.177:8011/adhanapi/reject-friend-request/'));
  //     request.body = json.encode({
  //       "user_id": userData.getUserData!.id.toString(),
  //       "request_id": notificationData.userId.toString(),
  //     });
  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();
  //     if(response.statusCode==200) {
  //       var data = jsonDecode(await response.stream.bytesToString());
  //       print("Friend Request Decline $data");
  //       notificationData.readStatus = true;
  //       _notifications.removeWhere((notification) => notification['id'] == notificationData.notificationId);
  //     }
  //   }
  //   catch(ex) {
  //     print("Error: $ex");
  //   }
  // }

  declineRequest(NotificationDataModal notificationData) async {
    try {
      final body = {
        "user_id": userData.getUserData!.id.toString(),
        "request_id": notificationData.userId.toString(),
      };
      final response = await ApiService().postRequest(
        'reject-friend-request/',
        body,
      );
      print("Friend Rejected: $response");
      notificationData.readStatus = true;
      _notifications.removeWhere((notification) => notification['id'] == notificationData.notificationId);
    }
      catch (e){
        print("Error: $e");
    }
    dashBoardController.fetchMissedPrayersCount();
  }

  ///Remove Accepted and decline rqwst from view

  // readNotificationMessage(String notificationId) async{
  //   print("NotificationId"+notificationId);
  //   var headers = {
  //     'Content-Type': 'application/json'
  //   };
  //   var request = http.Request('PUT', Uri.parse('http://182.156.200.177:8011/adhanapi/user_notifications/${userData.getUserData!.id}/'));
  //   request.body = json.encode({
  //     "id": notificationId,
  //     "type": "friend_request_acc",
  //     "is_read": false
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
  // }
  Future<void> readNotificationMessage(String notificationId) async {
    try {
      final body = {
        "id": notificationId,
        "type": "friend_request_acc",
        "is_read": false,
      };

      final response = await ApiService().putRequest(
        'user_notifications/${userData.getUserData!.id}/',
        body,
      );

      print("Notification marked as read: $response");
    } catch (ex) {
      print("Error marking notification as read: $ex");
    }
  }

}