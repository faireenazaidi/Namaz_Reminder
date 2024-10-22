import 'package:get/get.dart';
import '../../DashBoard/dashboardController.dart';

class HijriController extends GetxController {
  var selectedIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;

    // Get DashBoardController and update Islamic date
    final DashBoardController dashboardController = Get.find<DashBoardController>();
    dashboardController.updateIslamicDateBasedOnOption(index); // Update Hijri date in DashboardController
  }
}
