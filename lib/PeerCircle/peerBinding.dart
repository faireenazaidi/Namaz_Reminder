import 'package:get/get.dart';
import 'package:namaz_reminders/PeerCircle/peerController.dart';


class PeerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PeerController());
  }

}