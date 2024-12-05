import 'package:get/get.dart';

import 'InviteFriendsController.dart';


class InviteBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(InviteController());
  }

}