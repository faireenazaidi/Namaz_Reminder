import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Services/user_data.dart';

import '../Services/user_data.dart';
import 'leaderboardDataModal.dart';

class LeaderBoardController extends GetxController{

  UserData _userData = UserData();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    print("Date:$formattedDate");
    ;
  }

  String getFormattedDate() {
    // Get the current date and format it
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }

  var selectedDate = DateTime.now().obs;
  // var selectedTab = 'Daily'.obs;

  void updateSelectedDate(DateTime picked) {
  selectedDate.value = picked;
  }
  RxString selectedTab = 'Daily'.obs;
  String get getSelectedTab => selectedTab.value;
  set updateSelectedTab(String val){
    selectedTab.value = val;
    update();
  }
  // void updateSelectedTab(String tab) {
  // selectedTab.value = tab;
  //
  // }


  leaderboard(formattedDate) async{
    print(getFormattedDate);

    var request = http.Request('GET', Uri.parse('http://182.156.200.177:8011/adhanapi/prayer-response-friend/?user_id=4&date=24-09-2024'));


    http.StreamedResponse response = await request.send();
    print(request.url);

    if (response.statusCode == 200) {
     // print(await response.stream.bytesToString());
      var decodeData = jsonDecode(await response.stream.bytesToString());
      print("decodeData $decodeData");
      // updateLeaderboardList = decodeData;
      getLeaderboardList.value= LeaderboardDataModal.fromJson(decodeData);
      print("getLeaderboardList $getLeaderboardList");
      // print("@@@@@@@@@@@@ "+getLeaderboardList.toString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  Map<String,dynamic> leaderboardList = {};
  // LeaderboardDataModal?  getLeaderboardList;
  var getLeaderboardList = Rxn<LeaderboardDataModal>();
  // List<LeaderboardDataModal> get getLeaderboardList => List<LeaderboardDataModal>.from(
  //     leaderboardList.map((element) => LeaderboardDataModal.fromJson(element)).toList());
  set updateLeaderboardList(val){
    leaderboardList = val;
    update();
  }

  weeklyApi(String formattedDate) async {

    var request = http.Request('GET', Uri.parse('http://182.156.200.177:8011/adhanapi/friend-weekly-prayer-response/?user_id=${_userData.getUserData!.id}&date=$formattedDate'));


    http.StreamedResponse response = await request.send();
    print("URL ${request.url.toString()}");

    if (response.statusCode == 200) {
     // print(await response.stream.bytesToString());
      var data = await response.stream.bytesToString();
      print("WeeklyApi:$data");
    }
    else {
    print(response.reasonPhrase);
    }


    // List weeklyList = [];
    // List get get

  }






}