import 'package:get/get.dart';
import 'package:namaz_reminders/Login/loginController.dart';

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
  }

}