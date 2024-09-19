import 'package:get/get.dart';
import 'AddFriendController.dart';


class AddFriendBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AddFriendController());
  }

}