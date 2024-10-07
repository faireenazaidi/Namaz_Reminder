import 'package:get/get.dart';
import 'package:namaz_reminders/Notification/Setting/settingController.dart';

class SettingBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(SettingController());
  }

}