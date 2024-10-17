import 'package:get/get.dart';
import 'package:namaz_reminders/Login/loginController.dart';

import 'dashboardController.dart';

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    // Get.put(LoginController());
    Get.lazyPut<DashBoardController>(() => DashBoardController());
  }

}

