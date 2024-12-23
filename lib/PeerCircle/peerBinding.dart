import 'package:get/get.dart';
import 'package:namaz_reminders/PeerCircle/peerController.dart';


class PeerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PeerController>(() => PeerController());
    // Get.put(PeerController());
  }

}