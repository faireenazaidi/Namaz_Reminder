import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageController.dart';

class LocationPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LocationPageController>(() => LocationPageController());
  }

}