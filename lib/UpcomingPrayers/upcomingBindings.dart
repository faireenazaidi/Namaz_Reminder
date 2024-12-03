import 'package:get/get.dart';
import '../Login/loginController.dart';

class UpcomingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
