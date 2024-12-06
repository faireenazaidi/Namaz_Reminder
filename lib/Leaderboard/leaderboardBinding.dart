import 'package:get/get.dart';

import 'LeaderBoardController.dart';

class LeaderBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LeaderBoardController>(() => LeaderBoardController());
  }

}