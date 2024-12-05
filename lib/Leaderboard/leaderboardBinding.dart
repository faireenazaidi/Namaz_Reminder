import 'package:get/get.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardController.dart';

class LeaderBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LeaderBoardController>(() => LeaderBoardController());
  }

}