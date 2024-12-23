import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class PrivacyController extends GetxController {
  var location = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLocationStatus();
  }

  // Future<void> checkLocationStatus() async {
  //   bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
  //   location.value = isLocationEnabled;
  // }
  Future<void> checkLocationStatus() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      location.value = false; // Respect user's choice
    }
  }

  Future<void> toggleLocationAccess(bool isEnabled) async {
    if (isEnabled) {
      // Request permission if toggling on
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        location.value = true;
      } else {
        location.value = false;
      }
    } else {
      location.value = false;
    }
  }
}
