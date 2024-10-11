import 'package:get/get.dart';

class NamazAlertController extends GetxController {
  var selectedIndex = Rx<int?>(null);

  void selectItem(int index) {
    selectedIndex.value = index;
  }
}
