import 'package:get/get.dart';

class CustomDrawerController extends GetxController {
  var userName = 'Mansoor Khan'.obs;
  var email = 'mailto:mansoor.k@gmail.com'.obs;
  var notificationCount = 2.obs;
  var leaderboardCount = 5.obs;
  var missedPrayersCount = 33.obs;
  var isDarkMode = false.obs;
  var selectedIndex = (-1).obs; // Add this line to track the selected tile index

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

  void updateMissedPrayersCount(int count) {
    missedPrayersCount.value = count;
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }

  void selectIndex(int index) {
    selectedIndex.value = index; // Update the selected index
  }
}
