import 'dart:async';
import 'package:get/get.dart';
import '../Routes/approutes.dart';
import '../Services/user_data.dart';

// Position? latAndLong;
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

  pageRoute() async {
    // print("UserId${_userData.getUserData!.name.isEmpty}");
    if (_userData.getUserData == null) {
      Get.offNamed(AppRoutes.locationPageRoute);
    } else if (_userData.getUserData!.name.isEmpty) {
      Get.offNamed(AppRoutes.locationPageRoute);
    } else {
      Get.offNamed(AppRoutes.dashboardRoute);
    }

  }
}
