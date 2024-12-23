import 'package:get/get.dart';
import 'FAQsController.dart';

class FAQsBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FAQController>(() => FAQController());
    // Get.put(FAQController());
  }

}