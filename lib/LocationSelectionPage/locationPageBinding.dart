import 'package:get/get.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageController.dart';

class LocationPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LocationPageController>(() => LocationPageController());
  }

}