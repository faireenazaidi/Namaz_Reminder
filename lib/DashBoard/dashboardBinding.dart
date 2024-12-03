import 'package:get/get.dart';
import 'dashboardController.dart';

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
  }

}

