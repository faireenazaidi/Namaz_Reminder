import 'package:get/get.dart';
import 'notificationController.dart';


class NotificationBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NotificationController());
  }

}