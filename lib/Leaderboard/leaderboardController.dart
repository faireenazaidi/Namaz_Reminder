import 'package:get/get.dart';

class LeaderBoardController extends GetxController{

  var selectedDate = DateTime.now().obs;
  var selectedTab = 'Daily'.obs;

  void updateSelectedDate(DateTime picked) {
  selectedDate.value = picked;
  }

  void updateSelectedTab(String tab) {
  selectedTab.value = tab;

  }

}