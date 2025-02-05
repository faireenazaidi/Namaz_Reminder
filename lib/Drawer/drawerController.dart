import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  UserData userData = UserData();

  @override
  void onInit() {
    loadDarkModePreference();
    super.onInit();
  }
  // Load dark mode preference from storage
  void loadDarkModePreference() {
    final storedValue = GetStorage().read<bool>('isDarkMode');
    if (storedValue != null) {
      isDarkMode.value = storedValue;
      print("loaded dark mode preferences: $storedValue");
    }
    else
      {
        print("Noo dark mode preferences: ${isDarkMode.value}");
      }
  }
  // Storage instance
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

  // Save dark mode preference to storage
  void saveDarkModePreference() {
    GetStorage().write('isDarkMode', isDarkMode.value);
    print("Saveddd: ${isDarkMode.value}");
    saveDarkModePreference();
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;

  }
  void selectIndex(int index) {
    selectedIndex.value = index;
  }

}
