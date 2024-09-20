import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../Routes/approutes.dart';
import '../Services/user_data.dart';
import '../Widget/location_services.dart';

Position? latAndLong;
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
    Position latAndLong = await LocationServices().determinePosition();
    print("@@@@  XYZ ${latAndLong.latitude}   ${latAndLong.longitude}");
    print(latAndLong.longitude);
  }

  page() async {
    Timer(const Duration(seconds: 3), () => pageRoute());
  }

  pageRoute() async {
    Get.toNamed(AppRoutes.locationPageRoute);
  }

  // pageRoute() async {
  //   print("UserId${_userData.getUserData!.name.isEmpty}");
  //   if (_userData.getUserData!.name.isEmpty) {
  //     Get.toNamed(AppRoutes.locationPageRoute);
  //   } else {
  //     Get.toNamed(AppRoutes.dashboardRoute);
  //   }
  // }
}
