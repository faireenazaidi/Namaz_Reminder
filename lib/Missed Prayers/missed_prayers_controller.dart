import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardController.dart';

class MissedPrayersController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Get.lazyPut(()=>LeaderBoardController());
    Get.find<LeaderBoardController>().leaderboard(getFormattedDate());

  }
  String getFormattedDate() {
    // Get the current date and format it
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }
}