import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../DashBoard/dashboardController.dart';
import '../Services/user_data.dart';

class CustomDrawerController extends GetxController {
  final DashBoardController dashBoardController = Get.put(DashBoardController());
  var userName = 'Mansoor Khan'.obs;
  var email = 'mailto:mansoor.k@gmail.com'.obs;
  var notificationCount = 2.obs;
  var leaderboardCount = 5.obs;
  var isDarkMode = false.obs;
  var selectedIndex = (-1).obs;
  // var missedPrayersCount = 0.obs;
  // var pending = 0.obs;

  UserData userData = UserData();

  void updateUser(String name, String email) {
    userName.value = name;
    this.email.value = email;
  }

  void updateNotificationCount(int count) {
    notificationCount.value = count;
  }

  void updateLeaderboardCount(int count) {
    leaderboardCount.value = count;
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }

  void selectIndex(int index) {
    selectedIndex.value = index;
  }

  // Future<void> fetchMissedPrayersCount() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('http://182.156.200.177:8011/adhanapi/missed-prayers/?user_id=6&prayername=isha'),
  //         //Uri.parse('http://182.156.200.177:8011/adhanapi/missed-prayers/?user_id=${userData.getUserData!.id}&prayername=${dashBoardController.currentPrayer}')
  //
  //     );
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       int totalMissedPrayers = data['total_missed_prayers'] ?? 0;
  //       missedPrayersCount.value = totalMissedPrayers;
  //
  //       print('Total Missed Prayers: ${missedPrayersCount.value}');
  //       int totalPending = data['total_pending'] ?? 0;
  //       pending.value = totalPending;
  //       print('Pending: ${pending.value}');
  //     } else {
  //       print('Failed to fetch total missed prayers: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching total missed prayers: $e');
  //   }
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   print("CustomDrawerController initialized");
  //   // fetchMissedPrayersCount();
  // }
}
