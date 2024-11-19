import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class PrivacyController extends GetxController {
  var location = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLocationStatus();
  }

  Future<void> checkLocationStatus() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    location.value = isLocationEnabled;
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
      // Logic to handle location off state if needed
      location.value = false;
    }
  }
}

