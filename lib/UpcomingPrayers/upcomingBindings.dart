import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../Login/loginController.dart';

class UpcomingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
