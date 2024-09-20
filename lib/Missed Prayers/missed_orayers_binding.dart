import 'package:get/get.dart';
import 'missed_prayers_controller.dart';

class MissedPrayersBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MissedPrayersController());
  }
}