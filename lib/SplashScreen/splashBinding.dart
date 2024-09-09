import 'package:get/get.dart';
import 'package:namaz_reminders/SplashScreen/splashController.dart';

import '../LocationSelectionPage/locationPageController.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
  }

}