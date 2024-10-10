import 'package:get/get.dart';
import 'FAQsController.dart';

class FAQsBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(FAQController());
  }

}