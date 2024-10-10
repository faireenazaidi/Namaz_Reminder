import 'package:get/get.dart';
import'SettingController.dart';


class SettingBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(SettingController());
  }

}