import 'dart:async';

import 'package:get/get.dart';

import '../Routes/approutes.dart';
import '../Services/user_data.dart';

class SplashController extends GetxController {
  final UserData _userData = UserData();
  @override
  void onInit() {
    get();
    print("sssssssssssssssssssssssssssssssssssss");
    super.onInit();
  }

  get() async {
    page();
  }

  page() async {
    Timer(const Duration(seconds: 3), () => pageRoute());
  }

  // pageRoute() async {
  //   Get.toNamed(AppRoutes.locationPageRoute);
  // }

  pageRoute() async {
    print("UHID${_userData.getUserData?.uid}");
    if (_userData.getUserData?.uid.toString() == null) {
      Get.toNamed(AppRoutes.locationPageRoute);
    } else {
      Get.toNamed(AppRoutes.dashboardRoute);
    }
  }
}
