import 'package:get/get.dart';
import 'package:namaz_reminders/Profile/profileController.dart';


class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfileController());
  }

}